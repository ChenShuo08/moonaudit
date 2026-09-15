# moonaudit

`moonaudit` is a local MoonBit project structure audit CLI. It checks directory layout, package layout, README completeness, and frontmatter conventions so you can catch small structural issues before they slow down review and maintenance.

## Why

Small MoonBit projects often drift into inconsistent structure: missing `moon.pkg`, incomplete READMEs, missing frontmatter, and mixed `src/` and `tests/` layouts. These issues are usually easy to fix, but they reduce discoverability and reviewability. `moonaudit` gives you a fast local quality check for the most common project-level problems.

## Features

- Audit `moon.pkg`, `README`, `src/`, `tests/`, and frontmatter completeness
- Check README frontmatter fields like `title` and `description`
- Review Markdown and MoonBit files for YAML frontmatter presence
- Output a readable plain-text report with `ERROR`, `WARN`, and `INFO`
- Works well for local development, documentation review, and hackathon demos

## Install

Use this project as a local MoonBit CLI while iterating on audits.

```bash
moon test tests
```

## Usage

```bash
moon run src/main -- audit <path>
```

### Examples

```bash
moon run src/main -- audit .
moon run src/main -- audit examples/sample-project
```

## Project Structure

```text
src/
  main.mbt      audit CLI entrypoint
  types.mbt     project model and finding types
  fs.mbt        filesystem reader
  checks.mbt    audit rules
  report.mbt    report renderer
  cli.mbt       CLI argument parser
tests/
  audit_test.mbt CLI and check tests
examples/
  sample-project/
docs/
  proposal.md   one-page project proposal
```

## Sample Output

```text
moonaudit report
===============

[ERROR] missing-moon-pkg: Missing moon.pkg at project root.
[WARN] missing-tests: Missing tests/ directory.
[INFO] doc-missing-frontmatter: Document lacks YAML frontmatter: src/main.mbt

errors=1 warnings=1 info=1
```

## Contributing

Issues and PRs are welcome. For major changes, please open an issue first to discuss the audit rule and report format you want.

## License

Apache-2.0

## Quick Start

```bash
moon test tests
moon run src/main -- audit examples/sample-project
```

## Project Structure

```text
src/
  main.mbt      audit CLI entrypoint
  types.mbt     project model and finding types
  fs.mbt        filesystem reader
  checks.mbt    audit rules
  report.mbt    report renderer
  cli.mbt       CLI argument parser
tests/
  audit_test.mbt CLI and check tests
examples/
  sample-project/
docs/
  proposal.md   one-page project proposal
```

## Sample Output

```text
moonaudit report
===============

[ERROR] missing-moon-pkg: Missing moon.pkg at project root.
[WARN] missing-tests: Missing tests/ directory.

errors=1 warnings=1 info=0
```

## License

Apache-2.0

