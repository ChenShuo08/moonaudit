pub struct Project {
  let root :String
  let has_moon_pkg :Bool
  let has_readme :Bool
  let has_src :Bool
  let has_changelog :Bool
  let has_tests :Bool
  let frontmatter_files :List[String]
  let readme_frontmatter :Map[String, String]
  let packages :List[String]
}
