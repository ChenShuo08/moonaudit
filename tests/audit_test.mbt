/// Regression tests for the project audit CLI and checks.
///
/// Run with: moon test tests
use wbtest

fn test_audit_missing_project_files() -> Unit {
  wbtest::with_temp_dir("mb-audit-missing", fn (dir) {
    let report = run_audit(dir, "plain")
    assert_contains(report, "[ERROR] missing-moon-pkg: Missing moon.pkg at project root.")
    assert_contains(report, "[ERROR] missing-readme: Missing README at project root.")
    assert_contains(report, "[ERROR] missing-src: Missing src/ directory.")
    assert_contains(report, "[WARN] missing-tests: Missing tests/ directory.")
    assert_contains(report, "[WARN] missing-changelog: Missing CHANGELOG.md at project root.")
  })
}

fn test_audit_frontmatter_checks() -> Unit {
  wbtest::with_temp_dir("mb-audit-frontmatter", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "# Demo\n")
    wbtest::mkdir(dir ++ "/src")
    wbtest::write_file(dir ++ "/src/main.mbt", "pub fn main() {}\n")
    let report = run_audit(dir, "plain")
    assert_contains(report, "[WARN] readme-missing-title: README is missing frontmatter title.")
    assert_contains(report, "[WARN] readme-missing-description: README is missing frontmatter description.")
    assert_contains(report, "[INFO] doc-missing-frontmatter: Document lacks YAML frontmatter: " ++ dir ++ "/src/main.mbt")
  })
}

fn test_audit_valid_project() -> Unit {
  wbtest::with_temp_dir("mb-audit-valid", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "---\ntitle: Demo\ndescription: ok\n---\n# Demo\n")
    wbtest::mkdir(dir ++ "/src")
    wbtest::write_file(dir ++ "/src/main.mbt", "pub fn main() {}\n")
    wbtest::write_file(dir ++ "/CHANGELOG.md", "# Changelog\n")
    wbtest::mkdir(dir ++ "/tests")
    wbtest::write_file(dir ++ "/tests/main_test.mbt", "#[test]\nfn test_main() {}\n")
    let report = run_audit(dir, "plain")
    assert_eq(report, "moonaudit report\n===============\n\nNo findings.\n\nerrors=0 warnings=0 info=0\n")
  })
}

fn test_audit_json_output() -> Unit {
  wbtest::with_temp_dir("mb-audit-json", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "# Demo\n")
    let json = run_audit(dir, "json")
    assert(json.contains('"errors"'))
    assert(json.contains('"warnings"'))
    assert(json.contains('"info"'))
    assert(json.contains('readme-missing-title'))
  })
}

fn test_audit_markdown_output() -> Unit {
  wbtest::with_temp_dir("mb-audit-markdown", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "# Demo\n")
    wbtest::write_file(dir ++ "/src/main.mbt", "pub fn main() {}\n")
    let report = run_audit(dir, "markdown")
    assert(report.contains("# moonaudit report"))
    assert(report.contains("[ERROR] missing-readme"))
    assert(report.contains("**summary** errors="))
  })
}

fn test_audit_ignore_file() -> Unit {
  wbtest::with_temp_dir("mb-audit-ignore", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "---\ntitle: Demo\ndescription: ok\n---\n# Demo\n")
    wbtest::write_file(dir ++ "/src/main.mbt", "pub fn main() {}\n")
    wbtest::write_file(dir ++ "/src/internal/app.mbt", "pub fn main() {}\n")
    wbtest::write_file(dir ++ "/README.internal.md", "---\ntitle: internal\n---\n")
    wbtest::write_file(dir ++ "/.moonauditignore", "src/internal/app.mbt\nREADME.internal.md\n")
    let report = run_audit(dir ++ "?ignore-file=" ++ dir ++ "/.moonauditignore", "plain")
    assert(!report.contains("README.internal.md"))
  })
}

fn test_audit_severity_filter() -> Unit {
  wbtest::with_temp_dir("mb-audit-severity", fn (dir) {
    wbtest::write_file(dir ++ "/moon.pkg", '{"name":"demo"}')
    wbtest::write_file(dir ++ "/README.md", "# Demo\n")
    wbtest::write_file(dir ++ "/src/main.mbt", "pub fn main() {}\n")
    let report = run_audit(dir ++ "?severity=error", "plain")
    assert(report.contains("missing-readme"))
    assert(!report.contains("readme-missing-title"))
  })
}

fn run_audit(path :String, format :String) -> String {
  let project = @moonaudit.fs.read_project(path)
  let report = @moonaudit.checks.run(project)
  match format {
    "json" => @moonaudit.report.to_json(report)
    "markdown" => @moonaudit.report.to_markdown(report)
    _ => @moonaudit.report.render(report)
  }
}

fn assert_contains(text :String, expected :String) -> Unit {
  assert(text.contains(expected))
}