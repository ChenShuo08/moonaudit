# moonaudit

> Local MoonBit project structure audit CLI

`moonaudit` is a lightweight local CLI for MoonBit projects. It checks common structure drift issues: missing `moon.pkg`, incomplete README, missing frontmatter, missing `CHANGELOG.md`, deep package files, and inconsistent `src/` and `tests/` layout. It outputs graded findings in plain text, JSON, or Markdown, and supports ignore rules and severity filtering for review and CI.

## Why moonaudit

- Small MoonBit projects often drift into inconsistent structure.
- Missing or incomplete README and frontmatter reduce discoverability.
- Mixed `src/` and `tests/` layouts slow review and onboarding.
- moonaudit surfaces structural issues before review or release.
- It is built for MoonBit learners, maintainers, and hackathon teams.

## Quick start

```bash
moon test tests
moon run src/main -- audit .
moon run src/main -- audit . --format json
moon run src/main -- audit . --format markdown
moon run src/main -- audit . --severity error
moon run src/main -- self-audit
```

## Features

- Checks root project structure: `moon.pkg`, README, `src/`, `tests/`, `CHANGELOG.md`
- Checks README frontmatter: `title`, `description`
- Checks frontmatter conventions for Markdown and MoonBit files
- Outputs graded report: `ERROR`, `WARN`, `INFO`
- Supports plain, JSON, and Markdown output
- Supports `.moonauditignore` and `--ignore-file`
- Supports `--severity` filtering
- Supports `self-audit`
- Returns non-zero exit code on findings
- Includes regression tests and sample project
- Includes GitHub Actions CI

## Usage

### audit <path>

Audit a local MoonBit project path.

```bash
moon run src/main -- audit <path> [--format plain|json|markdown] [--ignore-file <path>] [--severity error|warning|info]
```

### self-audit

Audit the moonaudit project itself.

```bash
moon run src/main -- self-audit [--format plain|json|markdown]
```

## Output formats

### plain

```text
moonaudit report
===============

[ERROR] missing-readme: Missing README at project root.
[WARN] missing-tests: Missing tests/ directory.

errors=1 warnings=1 info=0
```

### json

```json
{
  "findings": [
    {
      "severity": "error",
      "code": "missing-readme",
      "message": "Missing README at project root."
    }
  ],
  "summary": {
    "errors": 1,
    "warnings": 1,
    "info": 0
  }
}
```

### markdown

```markdown
# moonaudit report

- [ERROR] **missing-readme**: Missing README at project root.
- [WARN] **missing-tests**: Missing tests/ directory.

**summary** errors=1 warnings=1 info=0
```

## Severity filter

Use `--severity` to filter findings.

- `error` shows only errors
- `warning` shows errors and warnings
- `info` shows all findings

```bash
moon run src/main -- audit . --severity error
```

## Ignore rules

Create `.moonauditignore` in the project root or pass `--ignore-file`.

```text
src/internal/**
README.internal.md
```

moonaudit supports directory ignores, file ignores, and comment lines starting with `#`.

## Checks

- `missing-moon-pkg`
- `missing-readme`
- `readme-missing-title`
- `readme-missing-description`
- `missing-src`
- `missing-changelog`
- `missing-tests`
- `no-package-dirs`
- `doc-missing-frontmatter`
- `deep-package-files`

## Exit code

moonaudit exits with code `0` when there are no findings after filtering. It exits with code `1` when findings remain. This makes it suitable for CI and pre-commit hooks.

## Project structure

```text
src/
  main.mbt      audit CLI entry
  types.mbt     project model and finding types
  fs.mbt        filesystem reader
  checks.mbt    audit rules
  report.mbt    report output
  cli.mbt       CLI argument parser
tests/
  audit_test.mbt CLI and rules tests
examples/
  sample-project/
docs/
  proposal.md   one-page proposal
CONTRIBUTING.md
README.md
README.zh-CN.md
```

## Development

```bash
moon test tests
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Apache-2.0