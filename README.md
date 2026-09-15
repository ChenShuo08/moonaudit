# moonaudit

`moonaudit` is a local MoonBit project structure audit CLI. It checks the basics that many small MoonBit projects still get wrong: missing `moon.pkg`, weak README structure, missing frontmatter, and inconsistent `src/` and `tests/` layout. Instead of manually reviewing these every time, you can run one local command and get a readable report you can act on.

## Why

Small MoonBit repositories often drift into structure that is "good enough," but still hard to review and maintain. Common problems include:

- missing or incomplete `moon.pkg`
- missing or thin README
- inconsistent `src/` and `tests/` organization
- missing frontmatter in README and docs

These issues do not usually break compilation, but they do slow down onboarding, documentation review, and collaboration. `moonaudit` is designed to catch those project-level issues early, before they become habits.

## Who is this for

- MoonBit learners building small CLI or learning projects
- open source maintainers who want a lightweight structure check
- hackathon participants who need fast, reviewer-friendly project hygiene
- teams that want a simple pre-review checklist without a full linter

## What it checks

- `moon.pkg` presence at the project root
- README presence and basic completeness
- README frontmatter fields such as `title` and `description`
- Markdown and MoonBit files for YAML frontmatter presence
- core package directories such as `src/` and `tests/`

## Features

- Local CLI with a simple `audit <path>` workflow
- readable plain-text report with `ERROR`, `WARN`, and `INFO`
- easy to run from the repo you are already editing
- lightweight and fast enough to run before commits and PRs
- useful for local docs review, teaching, and hackathon demos

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

## Report format

The report is designed to be short and actionable. Each finding includes a severity, a machine-friendly code, and a plain-English message. A summary line at the end shows how many errors, warnings, and info items were found.

This makes `moonaudit` useful as a pre-review checklist, not just a random scanner.

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

## When to use it

- before opening a PR, to catch structure and documentation gaps
- while reviewing someone else's MoonBit sample project
- before a hackathon demo or submission review
- when teaching project layout and README conventions

## Limitations

`moonaudit` focuses on structure and documentation conventions. It does not perform full linting, AST-level semantic analysis, or cross-package dependency analysis. For deeper code quality checks, pair it with the MoonBit linter and formatter.

## Sample Output

```text
moonaudit report
===============

[ERROR] missing-moon-pkg: Missing moon.pkg at project root.
[WARN] missing-tests: Missing tests/ directory.
[INFO] doc-missing-frontmatter: Document lacks YAML frontmatter: src/main.mbt

errors=1 warnings=1 info=1
```

## Roadmap

- more README and docs checks
- package boundary checks for MoonBit modules
- configurable rule sets and ignore paths
- richer output formats such as JSON and Markdown reports
- GitHub Actions workflow helper

## Contributing

Issues and PRs are welcome. If you want to add a new audit rule, the best path is:

1. open an issue describing the problem and example output
2. add a test case under `tests/`
3. implement the rule in `src/checks.mbt`
4. update this README if the user-facing behavior changes

## License

Apache-2.0

## 中文 README

本项目也提供中文说明，详见 [`README.zh-CN.md`](README.zh-CN.md)。
