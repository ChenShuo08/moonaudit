/// Render audit findings into a simple human-readable report.
///
/// The report format is intentionally plain text for easy review.
pub fn render(report :Report) -> String {
  let buf = StringBuilder()
  buf.write_string("moonaudit report\n")
  buf.write_string("===============\n\n")
  if report.findings.length() == 0 {
    buf.write_string("No findings.\n")
    return buf.to_string()
  }
  for finding in report.findings {
    let tag =
      match finding.severity {
        Error => "ERROR"
        Warning => "WARN"
        Info => "INFO"
      }
    buf.write_string("[")
    buf.write_string(tag)
    buf.write_string("] ")
    buf.write_string(finding.code)
    buf.write_string(": ")
    buf.write_string(finding.message)
    buf.write_string("\n")
  }
  buf.write_string("\n")
  let counts = count_severities(report.findings)
  buf.write_string("errors=")
  buf.write_string(@string.from_int(counts.errors))
  buf.write_string(" warnings=")
  buf.write_string(@string.from_int(counts.warnings))
  buf.write_string(" info=")
  buf.write_string(@string.from_int(counts.info))
  buf.write_string("\n")
  buf.to_string()
}

fn count_severities(findings :List[Finding]) -> ReportCounts {
  let errors = 0
  let warnings = 0
  let info = 0
  for finding in findings {
    match finding.severity {
      Error => errors = errors + 1
      Warning => warnings = warnings + 1
      Info => info = info + 1
    }
  }
  ReportCounts { errors, warnings, info }
}

struct ReportCounts {
  let errors :Int
  let warnings :Int
  let info :Int
}

