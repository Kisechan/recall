# 输出保留与清理设置

`recall config` 的 **Retention** 分类包含两个设置：

- **Output retention**（`retention_days`）：输出保留天数。正整数表示清理时删除多少天前的输出；`0` 表示禁用过期清理、永久保留输出。
- **Auto prune**（`auto_prune`）：是否在打开历史 TUI 时自动执行清理。`Off` 只关闭自动触发，不影响手动运行 `recall prune`。

默认值为保留 30 天、自动清理开启。选中 **Output retention** 后按 Enter 编辑天数；选中 **Auto prune** 后按 Space 或 Enter 切换开关。设置会立即保存，但保存本身不会执行清理。

## 0 天与 Auto prune Off 有什么区别？

两者都能阻止自动清理，但手动清理的行为不同：

| Output retention | Auto prune | 打开历史 TUI 时 | 手动执行 `recall prune` |
|---|---|---|---|
| 0 天 | On 或 Off | 不清理 | 不清理 |
| 60 天 | Off | 不清理 | 清理超过 60 天的输出 |
| 60 天 | On | 清理超过 60 天的输出 | 清理超过 60 天的输出 |

因此，“0 天 + On”也不会清理：只有保留天数大于 0 且自动清理开启，打开历史 TUI 时才会清理。保留天数为 0 时，自动清理开关没有实际作用；以后改为正数时，开关状态会再次生效。

## 按使用方式配置

### 永久保留输出

```toml
[retention]
retention_days = 0
auto_prune = false
```

`retention_days = 0` 已足以禁用自动和手动过期清理；这里同时关闭自动清理开关，使配置意图更清楚。

### 仅手动清理

```toml
[retention]
retention_days = 60
auto_prune = false
```

平时打开历史不会清理。需要时执行 `recall prune`，按配置的 60 天窗口清理。

### 自动清理

```toml
[retention]
retention_days = 60
auto_prune = true
```

每次打开历史 TUI 时清理超过 60 天的输出。这不是后台定时任务；没有打开历史 TUI 时，不会自动触发。也可以随时执行 `recall prune` 手动清理。

## 清理影响哪些数据？

过期时间按命令的开始时间计算。清理会删除存储的完整输出及用于输出搜索的文本，保留命令、执行时间、目录等元数据。因此，清理后仍能搜索到命令，但无法查看或搜索已清理的输出。

关闭自动清理、增大保留天数或改为永久保留，都不会恢复之前已清理的输出。
