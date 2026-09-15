#!/usr/bin/env -S moon run .

pub fn main() {
  let args = @moonaudit.cli.parse_args()
  match args {
    ["audit", path] => run_audit(path)
    _ => print("Usage: moon run src/main -- audit <path>\n")
  }
}

fn run_audit(path :String) -> Unit {
  let project = @moonaudit.fs.read_project(path)
  let report = @moonaudit.checks.run(project)
  print(@moonaudit.report.render(report))
}

