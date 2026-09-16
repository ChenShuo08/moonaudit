#!/usr/bin/env -S moon run .

pub fn main() {
  let args = @moonaudit.cli.parse_args()
  match args {
    ["audit", path] => run_audit(path, @moonaudit.cli.format_flag([]))
    ["audit", path, ..rest] => run_audit(path, @moonaudit.cli.format_flag(rest))
    _ => print("Usage: moon run src/main -- audit <path> [--format plain|json]\n")
  }
}

fn run_audit(path :String, format :String) -> Unit {
  let project = @moonaudit.fs.read_project(path)
  let report = @moonaudit.checks.run(project)
  match format {
    "json" => print(@moonaudit.report.to_json(report))
    _ => print(@moonaudit.report.render(report))
  }
}
