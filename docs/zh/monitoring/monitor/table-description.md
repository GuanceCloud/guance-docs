# 真值表说明
---

`likeTrue` 和 `likeFalse` 真值表如下：

| 值 | 类型 | 判定为 | 示例 |
| --- | --- | --- | --- |
| `true` | `Boolean` | `true` | `true` |
| `false` | `Boolean` | `false` | `false` |
| 大于0的数字 | `Integer`、`Float` | `true` | `1` |
| 小于等于0的数字 | `Integer`、`Float` | `false` | `0` |
| 转换为小写后值为`true`字符串 | `String` | `true` | `true` |
| 转换为小写后值为`"yes"`字符串 | `String` | `true` | `"Yes"` |
| 转换为小写后值为`"ok"`字符串 | `String` | `true` | `"OK"` |
| 转换为小写后值为`"on"`字符串 | `String` | `true` | `"ON"` |
| 转换为小写后值为`"1"`字符串 | `String` | `true` | `"1"` |
| 转换为小写后值为`"o"`字符串 | `String` | `true` | `"o"` |
| 转换为小写后值为`"y"`字符串 | `String` | `true` | `"y"` |
| 转换为小写后值为`false`字符串 | `String` | `false` | `false` |
| 转换为小写后值为`"no"`字符串 | `String` | `false` | `"No"` |
| 转换为小写后值为`"ng"`字符串 | `String` | `false` | `"NG"` |
| 转换为小写后值为`"off"`字符串 | `String` | `false` | `"OFF"` |
| 转换为小写后值为`"0"`字符串 | `String` | `false` | `"0"` |
| 转换为小写后值为`"x"`字符串 | `String` | `false` | `"x"` |
| 转换为小写后值为`"n"`字符串 | `String` | `false` | `"n"` |


**注意**：满足以上场景才会被判定满足真假条件，其他场景不匹配，即不会产生告警。