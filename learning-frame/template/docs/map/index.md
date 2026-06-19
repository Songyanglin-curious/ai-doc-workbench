---
id: map-index
type: index
---

# 能力地图

`map/` 是问题场景驱动的能力链图，不是知识分类表。

## 第一版只需要这些

- 问题场景：我在真实工作/学习中会遇到什么问题
- 能力链：解决这类问题时，能力节点如何先后调用
- 能力节点：可测试、可验证、可追踪的能力单元

## 个人默认方向

这套框架默认服务于工程能力补齐，优先从真实问题反推能力，而不是先追求课程完整性。

优先场景可以从这里长出来：

- 编程基本功与问题建模
- 接口联调与网络排查
- 后端状态、鉴权、权限模型
- 数据库与数据一致性
- 工程验证、测试、日志、排错
- AI 辅助开发中的独立判断

## 能力节点写法

不要写成名词：

```text
HTTP
Token
数据库事务
```

要写成可验证能力：

```text
能判断一次接口请求失败卡在浏览器、网络、服务端路由、鉴权还是业务处理
能区分 token、session、Redis 登录态分别保存什么以及如何失效
能解释事务隔离级别会怎样影响并发读写结果
```

## 文件类型

`map/` 中参与关联的文件必须有 YAML Front Matter。

- `type: scenario`
- `type: capability-chain`
- `type: capability-node`
- `type: index`

候选起点：

- [seed.md](seed.md)

模板见：

- [_templates/scenario.md](_templates/scenario.md)
- [_templates/capability-chain.md](_templates/capability-chain.md)
- [_templates/capability-node.md](_templates/capability-node.md)

## 关系维护规则

- AI 可以新增和修正普通关系，但必须汇报。
- 主能力链、关键前置、掌握状态必须由用户确认。
- AI 新增关系默认是候选关系。
- 发现循环依赖、孤立节点、没人使用的节点时，只提出建议，不直接改成结论。
