# Current Plan

## Task

- 将 `AGENTS.md` 收缩为 bootloader
- 将 `docs/index.md` 固定为按输入路由表
- 将详细规则集中到 `docs/context/rules.md`
- 将基线优先级与适用边界集中到 `docs/baseline/index.md`
- 补入“输入优先”和“维护确认”，并限制为仅在实质性变更时触发

## Baseline

- `AGENTS.md`
- `docs/index.md`
- `docs/context/index.md`
- `docs/context/rules.md`
- `docs/baseline/index.md`
- `docs/baseline/core.md`

## Non-Goals

- 不改顶层目录骨架
- 不新增 `docs/baseline/modules/<新模块>/`
- 不改 live repo 的代码实现

## Exit Criteria

- `AGENTS.md` 不再承担总手册角色
- `docs/index.md` 只负责按输入路由
- `context/` 只在证据不足时进入
- 基线优先级只在 `docs/baseline/index.md` 集中定义
- 维护确认只在实质性代码、结构或文档结论变更时触发

## Validation

- 明确目标的小任务：只需 `AGENTS.md` + 用户指定目标
- 普通模糊任务：`AGENTS.md -> docs/index.md -> 目标目录`
- 结构判断任务：`AGENTS.md -> docs/index.md -> baseline/`
- 复杂任务收口：`AGENTS.md -> docs/index.md -> plans/current.md`

## Notes

- 本次为入口层重构，已按上述范围实施
- 后续如需继续收口，可再归档到 `archive/`
