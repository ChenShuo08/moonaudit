#!/usr/bin/env -S moon run .

pub fn main() {
  let args = @cli.args()
  let rest = match args {
    [] => []
    [_, ..rest] => rest
  }
  match rest {
    ["audit", path] => run_audit(path, format_flag([]), ignore_file_flag([]), severity_flag([]))
    ["audit", path, ..more] => run_audit(path, format_flag(more), ignore_file_flag(more), severity_flag(more))
    _ => print("Usage: moon run src/main -- audit <path> [--format plain|json|markdown] [--ignore-file <path>] [--severity error|warning|info]\n")
  }
}

pub fn format_flag(args :List[String]) -> String {
  let args = remove_flag(args, "--format")
  for part in args {
    if part.starts_with("--format=") {
      return part.slice(9, part.length())
    }
  }
  "plain"
}

pub fn severity_flag(args :List[String]) -> Option[String] {
  let args = remove_flag(args, "--severity")
  for part in args {
    if part.starts_with("--severity=") {
      return Some(part.slice(11, part.length()))
    }
  }
  None
}

pub fn ignore_file_flag(args :List[String]) -> Option[String] {
  let args = remove_flag(args, "--ignore-file")
  for part in args {
    if part.starts_with("--ignore-file=") {
      return Some(part.slice(14, part.length()))
    }
    if part.starts_with("--ignore-file?") {
      return Some(part.slice(14, part.length()))
    }
  }
  None
}

pub fn remove_flag(flags :List[String], flag :String) -> List[String] {
  let out = []
  for item in flags {
    if item == flag || item.starts_with(flag ++ "=") || item.starts_with(flag ++ "?") {
      continue
    }
    out.push(item)
  }
  out
}

fn run_audit(path :String, format :String, ignore_file :Option[String], severity :Option[String]) -> Unit {
  let project = @moonaudit.fs.read_project(path)
  let project = apply_ignore_file(project, ignore_file)
  let report = @moonaudit.checks.run(project)
  let report = apply_severity_filter(report, severity)
  match format {
    "json" => print(@moonaudit.report.to_json(report))
    "markdown" => print(@moonaudit.report.to_markdown(report))
    _ => print(@moonaudit.report.render(report))
  }
}

fn apply_severity_filter(report :Report, severity :Option[String]) -> Report {
  match severity {
    Some(level) =>
      let level = level.trim().to_lower()
      let filtered = report.findings.filter(_, fn (finding) {
        match level {
          "error" => match finding.severity { Error => true | _ => false }
          "warning" => match finding.severity { Error | Warning => true | _ => false }
          "info" => true
          _ => true
        }
      })
      Report { findings: filtered }
    None => report
  }
}

fn apply_ignore_file(project :Project, ignore_file :Option[String]) -> Project {
  match ignore_file {
    Some(path) =>
      if @fs.exists(path) {
        let patterns = @fs.read(path).split("\n").filter(_, fn (line) { line != "" && !line.trim().starts_with("#") })
        let frontmatter_files = project.frontmatter_files.filter(_, fn (path) { !is_ignored(path, project.root, patterns) })
        let packages = project.packages.filter(_, fn (dir) { !is_ignored(dir, project.root, patterns) })
        Project {
          ..project,
          frontmatter_files,
          packages,
          has_src: project.has_src && !is_ignored(project.root ++ "/src", project.root, patterns),
          has_tests: project.has_tests && !is_ignored(project.root ++ "/tests", project.root, patterns),
          has_changelog: project.has_changelog && !is_ignored(project.root ++ "/CHANGELOG.md", project.root, patterns),
        }
      } else {
        project
      }
    None => project
  }
}

fn is_ignored(path :String, root :String, patterns :List[String]) -> Bool {
  let rel = path.slice(root.length() + 1, path.length())
  let normalized = if rel.starts_with("/") { rel.slice(1, rel.length()) } else { rel }
  for pattern in patterns {
    if match_path(normalized, pattern) {
      return true
    }
  }
  false
}

fn match_path(path :String, pattern :String) -> Bool {
  let trimmed = pattern.trim()
  if trimmed == "" {
    return false
  }
  let with_star = if trimmed.ends_with("/") { trimmed.slice(0, trimmed.length() - 1) ++ "/*" } else { trimmed }
  if with_star == "**" {
    return true
  }
  if with_star.starts_with("**/") {
    let suffix = with_star.slice(3, with_star.length())
    return path == suffix || path.contains("/" ++ suffix) || path.ends_with(suffix)
  }
  if with_star.contains("*") {
    let regex = with_star.replace(".", "\\.").replace("*", ".*").replace("?", ".")
    return @re.match(regex, path)
  }
  path == with_star
}