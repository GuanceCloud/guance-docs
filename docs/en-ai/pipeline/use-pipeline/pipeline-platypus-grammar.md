# Platypus Syntax
---

Below is the syntax definition for the Platypus language used by Pipeline processors. As support for different syntax features evolves, this document will be adjusted and updated accordingly.

## Identifiers and Keywords {#identifier-and-keyword}

### Identifiers {#identifier}

Identifiers are used to name objects such as variables or functions. Identifiers can include keywords; custom identifiers must not conflict with the keywords of the Pipeline data processor language.

Identifiers can consist of digits (`0-9`), letters (`A-Z a-z`), and underscores (`_`), but they cannot start with a digit and are case-sensitive:

- `_abc`
- `abc`
- `abc1`
- `abc_1_`

If an identifier needs to start with a non-letter or non-underscore character, or if it contains characters other than those listed above, it must be enclosed in backticks:

- `` `1abc` ``
- `` `@some-variable` ``
- `` ` This is an emoji variable👍` ``

**Special Convention**:

We use the identifier `_` to represent the input data for the Pipeline data processor. This parameter may be implicitly passed to some built-in functions.

In the current version, for forward compatibility, `_` is treated as an alias for `message`.

### Keywords {#keyword}

Keywords are words with special meanings, such as `if`, `elif`, `else`, `for`, `in`, `break`, `continue`, `nil`, etc. These words cannot be used as names for variables, constants, or functions.

## Comments {#comments}

Use `#` for line comments; inline comments are not supported.

```python
# This is a comment
a = 1 # This is a comment

"""
This is a (multi-line) string that serves as a comment
"""
a = 2

"String"
a = 3
```

## Built-in Data Types {#built-in-data-types}

In the Pipeline data processor language Platypus, variable types can dynamically change, but each value has a data type, which can be one of the **basic types** or a **composite type**.

When a variable is uninitialized, its value is `nil`, indicating no value.

### Basic Types {#basic-type}

#### Integer (int) Type {#int-type}

The integer type is 64-bit signed and currently supports only decimal integer literals, such as `-1`, `0`, `1`, `+19`.

#### Floating-point (float) Type {#float-type}

The floating-point type is 64-bit signed and currently supports only decimal floating-point literals, such as `-1.00001`, `0.0`, `1.0`, `+19.0`.

#### Boolean (bool) Type {#bool-type}

Boolean literals have only two values: `true` and `false`.

#### String (str) Type {#str-type}

String literals can be enclosed in double quotes or single quotes. Multi-line strings can be written using triple double quotes or triple single quotes.

- `"hello world"`
- `'hello world'`
- Using `"""` for multi-line strings

  ```python
  """hello
  world"""
  ```

- Using `'''` for multi-line strings
  
  ```python
  '''
  hello
  world
  '''
  ```

### Composite Types {#composite-type}

Map and list types differ from other types in that multiple variables can reference the same map or list object. Assignment does not copy the list or map in memory but instead references the memory address of the map/list value.

#### Map Type {#map-type}

The map type is a key-value structure where keys must be strings (currently), and there are no restrictions on the data type of values.

Elements in a map can be read or written using index expressions:

```python
a = {
  "1": [1, "2", 3, nil],
  "2": 1.1,
  "abc": nil,
  "def": true
}

# Since `a["1"]` is a list object, `b` just references the value of `a["1"]`
b = a["1"]

"""
Now `a["1"][0] == 1.1`
"""
b[0] = 1.1
```

#### List Type {#list-type}

The list type can store any number of values of any type.

Elements in a list can be read or written using index expressions:

```python
a = [1, "2", 3.0, false, nil, {"a": 1}]

a = a[0] # a == 1
```

## Operators {#operator}

The following table lists the operators supported by Platypus, with higher numbers indicating higher precedence:

| Precedence | Symbol | Associativity | Description |
| --- | --- | --- | --- |
| 1 | `=` | Right | Assignment; named parameters; lowest precedence |
| 1 | `+=` | Right | Assignment, left operand = left operand + right operand |
| 1 | `-=` | Right | Assignment, left operand = left operand - right operand |
| 1 | `*=` | Right | Assignment, left operand = left operand * right operand |
| 1 | `/=` | Right | Assignment, left operand = left operand / right operand |
| 1 | `%=` | Right | Assignment, left operand = left operand % right operand |
| 2 | `||` | Left | Logical "or" |
| 3 | `&&` | Left | Logical "and" |
| 4 | `in` | Left | Check if key exists in map; check if element exists in list; check if substring is contained in string |
| 5 | `>=` | Left | Conditional "greater than or equal to" |
| 5 | `>` | Left | Conditional "greater than" |
| 5 | `!=` | Left | Conditional "not equal to" |
| 5 | `==` | Left | Conditional "equal to" |
| 5 | `<=` | Left | Conditional "less than or equal to" |
| 5 | `<` | Left | Conditional "less than" |
| 6 | `+` | Left | Arithmetic "addition" |
| 6 | `-` | Left | Arithmetic "subtraction" |
| 7 | `*` | Left | Arithmetic "multiplication" |
| 7 | `/` | Left | Arithmetic "division" |
| 7 | `%` | Left | Arithmetic "modulus" |
| 8 | `!` | Right | Unary operator; logical "not"; applies to all six built-in data types |
| 8 | `+` | Right | Unary operator; positive sign; indicates positive numbers |
| 8 | `-` | Right | Unary operator; negative sign; reverses sign or indicates negative numbers |
| 9 | `[]` | Left | Subscript operator; retrieves list index or map key value |
| 9 | `()` | Left | Changes operator precedence; function call |

## Expressions {#expr}

Platypus uses the comma `,` as the expression separator, such as for passing arguments to function calls or initializing maps and lists.

In Platypus, expressions can have values, but **statements never have values**, meaning statements cannot be used as operands for operators like `=`, while expressions can.

### Literal Expressions {#list-expr}

Literals of various data types can serve as expressions, such as integers `100`, `-1`, `0`, floats `1.1`, booleans `true`, `false`, etc.

Here are two examples of composite type literal expressions:

- List literal expression

```txt
[1, true, "1", nil]
```

- Map literal expression

```txt
{
  "a": 1,
  "b": "2",
}
```

### Call Expressions {#call-expr}

The following is a function call to get the number of elements in a list:

```txt
len([1, 3, "5"])
```

### Binary Expressions {#binary-expr}

Binary expressions consist of binary operators and left and right operands.

Currently, assignment expressions are binary expressions and return a value; however, due to potential issues with assignment expressions, this syntax will be deprecated in favor of **assignment statements**.

```python
# 0
2 / 5

# 0.4, promotes left operand to float during calculation
2 / 5.0

# true
1 + 2 * 3 == 7 && 1 <= 2


# Due to the right associativity of `=`, `a = (b = 3)`, so `a == 3`
b == 3;
a = b = 3

# Note: Since assignment expressions will be deprecated, please replace them with assignment statements
b = 3
a = b

"a"   in  [1,"a"]   # true
"def" in  "abcdef"  # true
"a"   in  {"a": 1}  # true
"b"   in  {"a": 1}  # false

x = 1; y= [1]
x in y  # true
```

### Index Expressions {#index-expr}

Index expressions use the `[]` subscript operator to operate on elements of lists or maps.

Index expressions can be used to retrieve or modify elements of lists or maps, as well as add elements to maps. For lists, negative indices can be used.

Syntax examples:

```py
a = [1, 2 ,3, -1.]
b = {"a": [-1], "b": 2}

a[-1] = -2
b["a"][-1] = a[-1]

# Result
# a: [1,2,3,-2]
# b: {"a":[-2],"b":2}
```

### Parentheses Expressions {#bracket-expr}

Parentheses expressions can change the precedence of operands in binary expressions but do not change associativity:

```txt
# 1 + 2 * 3 == 7

(1 + 2) * 3  # == 9
```

## Statements {#stmt}

All expressions in Platypus can be considered value statements. When an expression ends with a statement separator `;` or `\n`, it is treated as a statement. For example, the following script contains four statements:

```go
len("abc")
1
a = 2; a + 2 * 3 % 2
```

### Value Statements (Expression Statements) {#value-stmt}

Expressions followed by a statement separator are considered value statements. The following are four valid statements:

```txt
# Float as a statement
1.;

# Function call expression as a statement
len("Hello World!"); len({"a": 1})

# Identifier as a statement
abc
```

### Assignment Statements {#assignment-stmt}

Syntax examples:

```py

key_a = "key-a"

# Identifier `a` as the left operand, assigns a list literal to `a`
a = [1, nil, 3]

# Index expression as the left operand
a[0] = 0
a[2] = {"key-b": "value-b"}
a[2][key_a] = 123
```

### Selection Statements {#select-stmt}

Platypus supports `if/elif/else` syntax:

```txt
if condition {

}
```

```txt
if condition {

} else {

}
```

```txt
if condition_1 {

} elif condition_2 {

} ... elif condition_n {

} else {

}
```

Similar to most programming languages, based on whether the `if/elif` conditions are met, the corresponding statement block is executed. If none of the conditions are met, the `else` branch is executed.

Currently, the condition can be any expression, as long as its value is one of the built-in data types. When the value is the default value of its type, the expression evaluates to `false`:

- For `int` type values, if the value is `0`, the condition is `false`; otherwise, it is `true`.
- For `float` type values, if the value is `0.0`, the condition is `false`; otherwise, it is `true`.
- For `string` type values, if the value is an empty string `""`, the condition is `false`; otherwise, it is `true`.
- For `bool` type values, the condition is the current value.
- For `nil` type values, the condition is `false`.
- For `map` type values, if the length is `0`, the condition is `false`; otherwise, it is `true`.
- For `list` type values, if the length is `0`, the condition is `false`; otherwise, it is `true`.

### Loop Statements {#loop-stmt}

Platypus supports `for` statements and `for in` statements.

The following two statements are only allowed within loop blocks:

- `continue` statement, skips the remaining statements and continues the next iteration
- `break` statement, terminates the loop

Using a `for` statement might cause infinite loops, so use it cautiously or prefer using `for in` statements.

```txt
for init-expr; condition; loop-expr {

}
```

```txt
for var_name in map_value/list_value/string_value  {

}
```

Usage examples:

- Using `for` to execute 10 iterations:

  ```py
  for a = 0; a < 10; a = a + 1 {
    
  }
  ```

- Using `for in` to iterate over all elements in a list:

  ```py
  b = "2"
  for a in ["1", "a" ,"2"] {
    b = b + a
    if b == "21a" {
      break
    }
  }
  # b == "21a"
  ```

- Using `for in` to iterate over all keys in a map:

  ```py
  d = 0
  map_a = {"a": 1, "b":2}
  for x in map_a {
    d = d + map_a[x]
  }
  ```

- Using `for in` to iterate over all characters in a string:

  ```py
  s = ""
  for c in "abcdef" {
    if s == "abc" {
      break
    } else {
      continue
    }
    s = s + "a"
  }
  # s == "abc"
  ```