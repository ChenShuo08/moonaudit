/// Minimal filesystem reader for local project moonaudit.
///
/// Reads files and lists directories for the audit checks.
pub fn read_project(root :String) -> Project {
  let has_moon_pkg = @fs.exists(root ++ "/moon.pkg")
  let has_readme = readme_exists(root)
  let has_src = @fs.exists(root ++ "/src")
  let has_changelog = @fs.exists(root ++ "/CHANGELOG.md")
  let has_tests = @fs.exists(root ++ "/tests")
  let frontmatter_files = collect_frontmatter_files(root)
  let readme_frontmatter = if has_readme { parse_frontmatter_file(root ++ "/README.md") } else { Map[] }
  let packages = collect_package_dirs(root)
  Project { root, has_moon_pkg, has_readme, has_src, has_changelog, has_tests, frontmatter_files, readme_frontmatter, packages }
}

fn readme_exists(root :String) -> Bool {
  @fs.exists(root ++ "/README.md") || @fs.exists(root ++ "/README.zh-CN.md") || @fs.exists(root ++ "/readme.md")
}

fn collect_frontmatter_files(root :String) -> List[String] {
  let out = []
  walk(root, "", out)
  out.filter(_, fn (path) { path.ends_with(".md") || path.ends_with(".mbt") })
}

fn collect_package_dirs(root :String) -> List[String] {
  let out = []
  if @fs.exists(root ++ "/src") {
    out.push("src")
  }
  if @fs.exists(root ++ "/tests") {
    out.push("tests")
  }
  out
}

fn walk(root :String, rel :String, out :List[String]) -> Unit {
  let target = if rel == "" { root } else { root ++ "/" ++ rel }
  if !@fs.is_dir(target) {
    return
  }
  for name in @fs.readdir(target) {
    if name == "." || name == ".." {
      continue
    }
    let child_rel = if rel == "" { name } else { rel ++ "/" ++ name }
    let child = root ++ "/" ++ child_rel
    if @fs.is_dir(child) {
      walk(root, child_rel, out)
    } else {
      out.push(child)
    }
  }
}

fn parse_frontmatter_file(path :String) -> Map[String, String] {
  if !@fs.exists(path) {
    return Map[]
  }
  let source = @fs.read(path)
  let lines = source.split("\n")
  match lines {
    ["---", ..rest] => parse_fields(rest)
    _ => Map[]
  }
}

fn parse_fields(lines :List[String]) -> Map[String, String] {
  let out = Map[]
  for line in lines {
    if line == "---" {
      break
    }
    if line.contains(":") {
      let idx = line.index_of(":").unwrap()
      let key = line.slice(0, idx).trim()
      let value = line.slice(idx + 1, line.length()).trim()
      if key != "" {
        out[key] = value
      }
    }
  }
  out
}

