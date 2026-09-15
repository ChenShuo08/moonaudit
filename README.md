# moonaudit

A MoonBit project structure audit CLI.

## Features

- Check common project structure problems for MoonBit projects
- Audit `moon.pkg`, `README`, `src/`, `tests/`, and frontmatter completeness
- Render a plain-text report with `ERROR`, `WARN`, and `INFO` findings
- Local CLI designed for small repositories and documentation workflows

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

