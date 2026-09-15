# moonaudit

`moonaudit` 是一个本地 MoonBit 项目结构审计 CLI。它会检查目录组织、包结构、README 完整性和 frontmatter 规范，帮助你在评审或维护前，先发现那些“不难但很烦”的结构问题。

## 为什么需要 moonaudit

小型 MoonBit 项目很容易慢慢漂移：缺少 `moon.pkg`、README 不完整、frontmatter 缺失、`src/` 和 `tests/` 的组织方式不统一。这些问题通常不难修，但会降低可维护性、可发现性和协作效率。`moonaudit` 就是用来在提交或评审前，快速暴露这些项目层面的问题。

## 功能特性

- 审计 `moon.pkg`、`README`、`src/`、`tests/` 等核心结构
- 检查 README 的 frontmatter，例如 `title` 和 `description`
- 检查 Markdown 与 MoonBit 文件是否包含 YAML frontmatter
- 输出可读的纯文本报告，包含 `ERROR`、`WARN`、`INFO`
- 适合本地开发、文档审查和黑客松演示

## 安装

目前以本地 MoonBit CLI 形式使用即可。

```bash
moon test tests
```

## 使用

```bash
moon run src/main -- audit <path>
```

### 示例

```bash
moon run src/main -- audit .
moon run src/main -- audit examples/sample-project
```

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

## 报告示例

```text
moonaudit report
===============

[ERROR] missing-moon-pkg: Missing moon.pkg at project root.
[WARN] missing-tests: Missing tests/ directory.
[INFO] doc-missing-frontmatter: Document lacks YAML frontmatter: src/main.mbt

errors=1 warnings=1 info=1
```

## 参与贡献

欢迎提交 Issue 和 PR。如果是较大的审计规则或输出格式变更，建议先开 Issue 讨论，再开始实现。

## 许可协议

Apache-2.0
