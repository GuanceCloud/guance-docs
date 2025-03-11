# Truth Table Explanation
---

The truth table for `likeTrue` and `likeFalse` is as follows:

| Value | Type | Evaluated As | Example |
| --- | --- | --- | --- |
| `true` | `Boolean` | `true` | `true` |
| `false` | `Boolean` | `false` | `false` |
| Numbers greater than 0 | `Integer`, `Float` | `true` | `1` |
| Numbers less than or equal to 0 | `Integer`, `Float` | `false` | `0` |
| String that converts to lowercase `true` | `String` | `true` | `true` |
| String that converts to lowercase `"yes"` | `String` | `true` | `"Yes"` |
| String that converts to lowercase `"ok"` | `String` | `true` | `"OK"` |
| String that converts to lowercase `"on"` | `String` | `true` | `"ON"` |
| String that converts to lowercase `"1"` | `String` | `true` | `"1"` |
| String that converts to lowercase `"o"` | `String` | `true` | `"o"` |
| String that converts to lowercase `"y"` | `String` | `true` | `"y"` |
| String that converts to lowercase `false` | `String` | `false` | `false` |
| String that converts to lowercase `"no"` | `String` | `false` | `"No"` |
| String that converts to lowercase `"ng"` | `String` | `false` | `"NG"` |
| String that converts to lowercase `"off"` | `String` | `false` | `"OFF"` |
| String that converts to lowercase `"0"` | `String` | `false` | `"0"` |
| String that converts to lowercase `"x"` | `String` | `false` | `"x"` |
| String that converts to lowercase `"n"` | `String` | `false` | `"n"` |

**Note**: Only values that meet the above scenarios will be evaluated as true or false conditions. Other scenarios do not match, meaning no alerts will be triggered.