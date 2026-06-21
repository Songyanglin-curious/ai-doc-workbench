# Modules

本目录用于放置已经值得单独描述的稳定模块。

## 什么时候创建模块目录

仅当满足以下任一情况时，才新增 `modules/<模块名>/`：

- 模块职责已经清晰
- 模块边界已经值得单独约束
- 模块代码入口已经值得单独记录

不要为了“看起来完整”预建大量空模块。

## 命名规则

- 使用中文业务名
- 每个模块目录必须有 `index.md`

## 模块 `index.md` 固定 sections

- `Purpose`
- `Current Responsibilities`
- `Boundaries`
- `Code Map`
- `Local Rules`
- `Related Inputs`
- `Related References`
- `Change Notes`

## 维护边界

- `Code Map`、`Related Inputs`、`Related References`、`Change Notes`、非结构性的 `Local Rules` 可由 AI 维护。
- `Purpose`、`Current Responsibilities`、`Boundaries` 以及长期结构判断，必须先确认或强制人审。
- 新增模块目录前，先确认其是否已经达到“值得单独描述”的阈值。
