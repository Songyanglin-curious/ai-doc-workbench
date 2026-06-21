# Tools

本目录放可选工具。日常学习不需要先运行工具；当 `map/` 变大、关系变多时再使用。

## check-map.ps1

检查 `docs/map/` 中的结构关系：

- front matter 是否存在
- `id` 是否重复
- `type` / `status` 是否在允许范围内
- 常见关系字段是否引用了已有 map id

运行方式：

```powershell
powershell -ExecutionPolicy Bypass -File tools\check-map.ps1
```

注意：它只检查结构，不判断你是否真的掌握某能力。