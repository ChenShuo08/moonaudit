/// Minimal CLI argument parser for the audit command.
///
/// Supports:
/// - `audit <path>`
/// - `audit <path> --format json`
pub fn parse_args() -> List[String] {
  match @cli.args() {
    [] => []
    [_, ..rest] => rest
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

pub fn ignore_file_flag(args :List[String]) -> Option[String] {
  let args = remove_flag(args, "--ignore-file")
  for part in args {
    if part.starts_with("--ignore-file=") {
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
