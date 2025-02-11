# Truth Table Explanation
---

The truth table for `likeTrue` and `likeFalse` is as follows:

| Value | Type | Evaluated as | Example |
| --- | --- | --- | --- |
| `true` | `Boolean` | `true` | `true` |
| `false` | `Boolean` | `false` | `false` |
| Positive numbers | `Integer`, `Float` | `true` | `1` |
| Non-positive numbers | `Integer`, `Float` | `false` | `0` |
| String that converts to `true` in lowercase | `String` | `true` | `true` |
| String that converts to `"yes"` in lowercase | `String` | `true` | `"Yes"` |
| String that converts to `"ok"` in lowercase | `String` | `true` | `"OK"` |
| String that converts to `"on"` in lowercase | `String` | `true` | `"ON"` |
| String that converts to `"1"` in lowercase | `String` | `true` | `"1"` |
| String that converts to `"o"` in lowercase | `String` | `true` | `"o"` |
| String that converts to `"y"` in lowercase | `String` | `true` | `"y"` |
| String that converts to `false` in lowercase | `String` | `false` | `false` |
| String that converts to `"no"` in lowercase | `String` | `false` | `"No"` |
| String that converts to `"ng"` in lowercase | `String` | `false` | `"NG"` |
| String that converts to `"off"` in lowercase | `String` | `false` | `"OFF"` |
| String that converts to `"0"` in lowercase | `String` | `false` | `"0"` |
| String that converts to `"x"` in lowercase | `String` | `false` | `"x"` |
| String that converts to `"n"` in lowercase | `String` | `false` | `"n"` |

**Note**: Only values that meet the above scenarios will be evaluated as true or false. Other scenarios do not match, meaning no alert will be generated.