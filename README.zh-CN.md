# moonaudit

`moonaudit` 是一个本地 MoonBit 项目结构审计 CLI。它会检查那些小项目最容易慢慢“漂”出来的结构问题：缺少 `moon.pkg`、README 不完整、frontmatter 缺失、`src/` 和 `tests/` 组织不统一。你不需要每次提交前都人工 review 一遍，只要跑一个本地命令，就能拿到一份可直接处理的报告。

## 为什么需要 moonaudit

小型 MoonBit 项目经常进入一种“勉强能用，但不好维护”的状态。常见问题包括：

- 缺少 `moon.pkg`
- README 缺失或过于简略
- 文档缺少 frontmatter
- `src/` 和 `tests/` 的组织方式不统一

这些问题通常不难修，但会降低可维护性、可发现性和协作效率。`moonaudit` 就是用来在这些问题变成习惯之前，先快速暴露出来。

## 适用人群

- 正在学习 MoonBit 并做小项目的开发者
- 开源项目维护者，想做轻量结构检查
- 黑客松参赛者，需要快速整理项目结构
- 团队希望有一个简单、低负担的提交前检查清单

## 检查项

- 项目根目录是否包含 `moon.pkg`
- 是否存在 README，以及 README 是否足够完整
- README 的 frontmatter 是否包含 `title`、`description` 等字段
- Markdown 和 MoonBit 文件是否包含 YAML frontmatter
- 核心目录 `src/`、`tests/` 是否存在

## 功能特性

- 本地 CLI，使用方式简单：`moon run src/main -- audit <path>`
- 输出可读的纯文本报告，包含 `ERROR`、`WARN`、`INFO`
- 支持 JSON 格式输出，便于脚本和 CI 集成
- 适合本地开发、文档审查、教学和黑客松演示
- 轻量、快速，能融入日常开发流程

## 安装

目前以本地 MoonBit CLI 形式使用即可。

```bash
moon test tests
```

## 使用

```bash
moon run src/main -- audit <path>
moon run src/main -- audit <path> --format json
```

### 示例

```bash
moon run src/main -- audit .
moon run src/main -- audit examples/sample-project
moon run src/main -- audit . --format json
```

## 报告格式

报告设计为短而可执行。每个 finding 都会包含严重级别、问题代码和可直接阅读的说明。报告末尾还会统计 errors、warnings 和 info 的数量。

JSON 输出会包含 findings 和 summary，方便你接续脚本、编辑器插件或 CI 使用。

## 项目结构

```text
src/
  main.mbt      audit CLI 入口
  types.mbt     项目模型与 finding 类型
  fs.mbt        文件系统读取
  checks.mbt    审计规则
  report.mbt    报告输出
  cli.mbt       命令行参数解析
tests/
  audit_test.mbt CLI 与规则测试
examples/
  sample-project/
docs/
  proposal.md   一页项目说明
```

## 适用场景

- 提交 PR 前快速检查结构和文档问题
- 审阅他人的 MoonBit 示例项目
- 黑客松演示或提交前的项目整理
- 教学时讲解项目结构和 README 规范

## 限制说明

`moonaudit` 聚焦在结构和文档规范上，不会做完整 lint、AST 级语义分析或跨包依赖检查。如果你需要更深的代码质量检查，可以配合 MoonBit 官方 linter 和 formatter 一起使用。

## 报告示例

```text
moonaudit report
===============

[ERROR] missing-moon-pkg: Missing moon.pkg at project root.
[WARN] missing-tests: Missing tests/ directory.
[INFO] doc-missing-frontmatter: Document lacks YAML frontmatter: src/main.mbt

errors=1 warnings=1 info=1
```

## 路线图

- 更多 README 和文档检查规则
- MoonBit 模块边界检查
- 可配置规则集和 ignore paths
- 更多输出格式，例如 JSON 和 Markdown 报告
- GitHub Actions 工作流辅助

## 参与贡献

欢迎提交 Issue 和 PR。如果要新增审计规则，推荐流程：

1. 先开 Issue 描述问题和期望输出
2. 在 `tests/` 增加测试用例
3. 在 `src/checks.mbt` 中实现规则
4. 若用户可见行为变化，同步更新 README

## 许可协议

Apache-2.0

## English README

英文说明见 [`README.md`](README.md)。
