# moonaudit project proposal

## 基本信息

- Project name: moonaudit
- 赛道方向：开发体验工具 / Web 与网络基础设施辅助工具
- 项目链接：https://github.com/ChenShuo08/moonaudit
- One-line description: a local MoonBit project structure audit CLI that checks directory layout, package layout, README completeness, frontmatter conventions, and ignore support.

## Problem

Small MoonBit projects often drift into inconsistent structure: missing `moon.pkg`, incomplete READMEs, missing frontmatter, missing `CHANGELOG.md`, and mixed `src/` and `tests/` layouts. These issues hurt maintainability, discoverability, and collaboration. `moonaudit` provides a lightweight local audit tool to surface structural problems before review or release.

## Goals

- Provide a local CLI: `moon run src/main -- audit <path>`
- Check root project structure: `moon.pkg`, README, `src/`, `tests/`, `CHANGELOG.md`
- Check README frontmatter: `title`, `description`
- Check frontmatter conventions across docs and source files
- Support `.moonauditignore` and `--ignore-file` to skip generated or example paths
- Output a readable report with `ERROR`, `WARN`, and `INFO`
- Support `plain`, `json`, and `markdown` output

## MVP Features

1. `audit <path>` with `plain`, `json`, and `markdown` output
2. `.moonauditignore` and `--ignore-file` support
3. Checks for `moon.pkg`, README, `src/`, `tests/`, `CHANGELOG.md`
4. README frontmatter validation
5. Frontmatter checks for docs/source files
6. Sample project and regression tests
7. GitHub Actions CI for core regression checks

## Out of Scope

- No full linter, AST-level semantic analysis, or release packaging in v1
- Focus on structure, README frontmatter, changelog presence, documentation conventions, and ignore support with high signal and low overhead

## Deliverables

- MoonBit 主实现仓库
- README + 快速开始
- 可运行示例与测试
- GitHub Actions CI
- 演示说明或录屏

## Suggested repo metadata

- English name: `moonaudit`
- Description: `Local MoonBit project structure audit CLI`
- Topics: `moonbit`, `cli`, `developer-experience`, `audit`

## 项目特色

- 以 MoonBit 为主语言实现
- 适合黑客松的“开发体验/工具链”方向
- 范围小、演示直观、容易评审理解价值