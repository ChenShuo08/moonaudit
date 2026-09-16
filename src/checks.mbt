/// Audit rules for a minimal MoonBit project structure.
///
/// The checks are intentionally small and opinionated, focusing on the
/// most common structure and documentation problems in small projects.
pub fn run(project :Project) -> Report {
  let findings = []
  if !project.has_moon_pkg {
    findings.push( Finding { severity: Error, code: "missing-moon-pkg", message: "Missing moon.pkg at project root." } )
  }
  if !project.has_readme {
    findings.push( Finding { severity: Error, code: "missing-readme", message: "Missing README at project root." } )
  } else {
    if !project.readme_frontmatter.contains("title") {
      findings.push( Finding { severity: Warning, code: "readme-missing-title", message: "README is missing frontmatter title." } )
    }
    if !project.readme_frontmatter.contains("description") {
      findings.push( Finding { severity: Warning, code: "readme-missing-description", message: "README is missing frontmatter description." } )
    }
  }
  if !project.has_src {
    findings.push( Finding { severity: Error, code: "missing-src", message: "Missing src/ directory." } )
  }
  if !project.has_changelog {
    findings.push( Finding { severity: Warning, code: "missing-changelog", message: "Missing CHANGELOG.md at project root." } )
  }
  if !project.has_tests {
    findings.push( Finding { severity: Warning, code: "missing-tests", message: "Missing tests/ directory." } )
  }
  if project.packages.length() == 0 {
    findings.push( Finding { severity: Warning, code: "no-package-dirs", message: "No src/ or tests/ package directories found." } )
  }
  for path in project.frontmatter_files {
    if !path.ends_with("moon.pkg") && !path.contains("/.git/") && !path.contains("/.github/") {
      let missing_frontmatter = !has_frontmatter(path)
      if missing_frontmatter {
        findings.push( Finding { severity: Info, code: "doc-missing-frontmatter", message: "Document lacks YAML frontmatter: " ++ path } )
      }
    }
  }
  Report { findings }
}

fn has_frontmatter(path :String) -> Bool {
  if !@fs.exists(path) {
    return false
  }
  let source = @fs.read(path)
  let lines = source.split("\n")
  match lines {
    ["---", ..rest] => true
    _ => false
  }
}