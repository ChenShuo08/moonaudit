/// Minimal CLI argument parser for the audit command.
///
/// Returns the command and its arguments, or an empty list when no arguments are given.
pub fn parse_args() -> List[String] {
  match @cli.args() {
    [] => []
    [_, ..rest] => rest
  }
}
