# moonaudit 项目申报书

**基本信息**

- 项目名称：moonaudit：本地 MoonBit 项目结构审计 CLI
- 参赛者：陈铄
- 联系方式：g1ker@qq.com
- GitHub 仓库链接：[https://github.com/ChenShuo08/moonaudit](https://github.com/ChenShuo08/moonaudit)
- 项目方向：MoonBit 开发体验工具 / 应用与内容工具
- 是否为原创项目：是

**项目简介**

moonaudit 是一个本地 MoonBit 项目结构审计 CLI，用于检查 MoonBit 小项目最常见的结构漂移问题，包括缺少 `moon.pkg`、README 不完整、frontmatter 缺失、`CHANGELOG.md` 缺失、过深的包文件路径，以及 `src/` 与 `tests/` 组织不一致。项目面向 MoonBit 学习者、开源维护者、黑客松参赛者和团队开发场景，提供可本地运行的 `audit` 命令、分级报告和回归测试，帮助开发者在提交 PR、审查示例项目或准备演示前，快速发现“不难修但很分散”的项目结构问题。

**项目方向，通用性说明**

- 属于“语言与开发工具”和“应用与内容工具”交叉方向，聚焦 MoonBit 本地开发体验。
- 工具不绑定特定业务领域，可复用于示例项目、教学仓库、团队 MoonBit 小项目和黑客松提交物。
- 输出格式兼顾人类审阅与机器集成，因此既可用于个人本地检查，也可用于 CI / 预提交钩子。

**预期使用场景**

- 提交 PR 前快速检查项目结构，减少 reviewer 被基础结构问题分散注意力的情况。
- 在 CI 或预提交钩子中运行 `moonaudit`，把项目结构规范纳入自动化门禁。
- 教学或团队 onboard 时，用 `moonaudit` 给 MoonBit 示例项目做统一体检，降低协作成本。

**核心功能**

- 检查 `moon.pkg`、README、`src/`、`tests/`、`CHANGELOG.md` 等核心结构；
- 检查 READLE frontmatter：`title`、`description`；
- 检查 Markdown 与 MoonBit 文件的 YAML frontmatter；
- 输出分级报告：`ERROR`、`WARN`、`INFO`；
- 支持 plain / JSON / Markdown 输出，便于脚本和 CI 集成；
- 支持 `.moonauditignore` 与 `--ignore-file`；
- 支持 `--severity` 过滤；
- 支持 `self-audit`；
- 发现问题时返回非零退出码；
- 提供回归测试与示例项目。

**GitHub 仓库链接**

- [https://github.com/ChenShuo08/moonaudit](https://github.com/ChenShuo08/moonaudit)
