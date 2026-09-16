/// Project model used by the audit CLI.
///
/// Represents a minimal MoonBit project and individual check results.
pub struct Project {
  let root :String
  let has_moon_pkg :Bool
  let has_readme :Bool
  let has_changelog :Bool
  let has_src :Bool
  let has_tests :Bool
  let frontmatter_files :List[String]
  let readme_frontmatter :Map[String, String]
  let packages :List[String]
}

pub enum Severity {
  Error
  Warning
  Info
}

pub struct Finding {
  let severity :Severity
  let code :String
  let message :String
}

pub struct Report {
  let findings :List[Finding]
}
