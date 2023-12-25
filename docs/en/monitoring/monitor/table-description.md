# Truth Table
---
Truth tables of `likeTrue` and `likeFalse` are as follows:

| Value | Type | Determined to be | Example |
| --- | --- | --- | --- |
| `true` | `Boolean` | `true` | `true` |
| `false` | `Boolean` | `false` | `false` |
| Numbers greater than 0 | `Integer`、`Float` | `true` | `1` |
| Numbers less than or equal to 0 | `Integer`、`Float` | `false` | `0` |
| Converted to a string with a value of`true`Conveafter lowercaserted to a string with a value of | `String` | `true` | `true` |
| Converted to a string with a value of`"yes"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"Yes"` |
| Converted to a string with a value of`"ok"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"OK"` |
| Converted to a string with a value of`"on"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"ON"` |
| Converted to a string with a value of`"1"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"1"` |
| Converted to a string with a value of`"o"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"o"` |
| Converted to a string with a value of`"y"`Conveafter lowercaserted to a string with a value of | `String` | `true` | `"y"` |
| Converted to a string with a value of`false`Conveafter lowercaserted to a string with a value of | `String` | `false` | `false` |
| Converted to a string with a value of`"no"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"No"` |
| Converted to a string with a value of`"ng"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"NG"` |
| Converted to a string with a value of`"off"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"OFF"` |
| Converted to a string with a value of`"0"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"0"` |
| Converted to a string with a value of`"x"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"x"` |
| Converted to a string with a value of`"n"`Conveafter lowercaserted to a string with a value of | `String` | `false` | `"n"` |

**Note**: Only when the above scenarios are met will it be judged that the true and false conditions are met, and other scenarios do not match, that is, no alert will be generated.