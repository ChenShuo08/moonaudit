# moonaudit - project proposal

## 基本信息

- Project name: moonaudit
- 赛道方向：应用与内容工具 / 开发体验工具
- 项目链接：（公开仓库创建后填入）
- One-line description: a local MoonBit project structure audit CLI that checks directory layout, package layout, README completeness, and frontmatter conventions.

## Problem

Small MoonBit projects often drift into inconsistent structure: missing `moon.pkg`, incomplete READMEs, missing frontmatter, and mixed `src/` and `tests/` layouts. These issues hurt maintainability, discoverability, and collaboration. `moonaudit` provides a lightweight local audit tool to surface structural problems before review or release.

## Goals

- Provide a local CLI: `moon run src/main -- audit <path>`
- Check root project structure: `moon.pkg`, `README`, `src/`, `tests/`
- Check README frontmatter: `title`, `description`
- Check frontmatter conventions across docs and source files
- Output a readable report with `ERROR`, `WARN`, and `INFO`

## MVP Features

1. 扫描 MoonBit 项目根目录和关键目录
2. 检查 `moon.pkg`、README、`src/`、`tests/` 是否存在
3. 检查 README 的 frontmatter 完整性
4. 检查项目内 Markdown/MoonBit 文件的 frontmatter 规范
5. 输出分级审计报告和统计信息
 6. Include a sample project and regression tests

## Out of Scope

- No full linter, AST-level semantic analysis, or release packaging in v1
- Focus on structure, README frontmatter, and documentation conventions with high signal and low overhead

## Deliverables

- MoonBit 主实现仓库
- README + 快速开始
- 可运行示例与测试
- 演示说明或录屏

## Suggested repo metadata

- English name: `moonaudit`
- Description: `Local MoonBit project structure audit CLI`
- Topics: `moonbit`, `cli`, `developer-experience`, `audit`

## 项目特色

- 以 MoonBit 为主语言实现
- 适合黑客松的“开发体验/工具链”方向
- 范围小、演示直观、容易评审理解价值
