# moonaudit

> Local MoonBit project structure audit CLI

- English: [`README.md`](README.md)
- 中文：`README.zh-CN.md`

`moonaudit` 是一个本地 MoonBit 项目结构审计 CLI，用于检查 MoonBit 小项目最常见的结构漂移问题，包括缺少 `moon.pkg`、README 不完整、frontmatter 缺失，以及 `src/` 与 `tests/` 组织不一致。项目面向 MoonBit 学习者、开源维护者、黑客松参赛者和团队开发场景，提供可本地运行的 `audit` 命令、分级报告和回归测试，帮助开发者在提交 PR、审查示例项目或准备演示前，快速发现“不难修但很分散”的项目结构问题。

## 快速开始

```bash
moon test tests
moon run src/main -- audit .
moon run src/main -- audit . --format json
moon run src/main -- audit . --format markdown
```

## 功能特性

- 检查 `moon.pkg`、README、`src/`、`tests/`、`CHANGELOG.md` 等核心结构
- 检查 README frontmatter：`title`、`description`
- 检查 Markdown 与 MoonBit 文件的 YAML frontmatter
- 输出分级报告：`ERROR`、`WARN`、`INFO`
- 支持 plain / JSON / Markdown 输出，便于脚本、审查和 CI 集成
- 支持 `--severity` 过滤，可按 `error` / `warning` / `info` 只看某类问题
- 支持 `self-audit` 子命令，直接检查 moonaudit 自身项目结构
- 发现问题时返回非零退出码，便于 CI / 预提交脚本集成

## 使用场景

- 提交 PR 前快速检查项目结构
- 审阅他人 MoonBit 示例项目
- 黑客松演示或提交前的项目整理
- 教学时讲解项目结构和 README 规范

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
\.github/
  workflows/
    ci.yml      GitHub Actions
```

## 自定义忽略文件

在项目根目录创建 `.moonauditignore` 或通过 `--ignore-file` 传入，可跳过不需要审计的路径。

- 支持通配符与按目录忽略
- 适合临时忽略 generator 输出、旧示例或文档快照
- 示例：

```text
src/internal/**
README.internal.md
```

## 限制说明

`moonaudit` 聚焦结构和文档规范，不做完整 lint、AST 级语义分析或跨包依赖检查。

## 许可协议

Apache-2.0




