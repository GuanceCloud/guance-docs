# Platypus Syntax
---

The following is the syntax definition of the Platypus language used by the Pipeline processor. As support for different syntaxes is gradually implemented, this document will be adjusted and updated to varying degrees.

## Identifiers and Keywords {#identifier-and-keyword}

### Identifiers {#identifier}

Identifiers are used to identify objects and can be used to represent a variable, function, etc. Identifiers include keywords; custom identifiers should not duplicate the keywords of the Pipeline data processor language.

Identifiers can be composed of numbers (`0-9`), letters (`A-Z a-z`), and underscores (`_`), but the first character cannot be a number and they are case-sensitive:

- `_abc`
- `abc`
- `abc1`
- `abc_1_`

If you need to start with a non-letter or non-underscore, or use characters other than those mentioned in an identifier, you need to use backticks:

- `` `1abc` ``
- `` `@some-variable` ``
- `` `This is an emoji variable 👍` ``

**Special Agreement**:

We agree to use the identifier `_` to represent the input data of the Pipeline data processor, which may be implicitly passed to some built-in functions.

In the current version, to maintain backward compatibility, `_` will be considered an alias for `message`.

### Keywords {#keyword}

Keywords are words with special meanings, such as `if`, `elif`, `else`, `for`, `in`, `break`, `continue`, `nil`, etc. These words cannot be used as names for variables, constants, or functions.

## Comments {#comments}

The `#` character is used for line comments; inline comments are not supported.

```python
# This is a line comment
a = 1 # This is a line comment

"""
This is a (multi-line) string, used as a comment
"""
a = 2

"string"
a = 3
```

## Built-in Data Types {#built-in-data-types}

In the Platypus language of the Pipeline data processor, by default, the type of a variable's value can change dynamically, but each value has its data type, which can be one of the **basic types** or a **composite type**.

When a variable is not assigned, its value is nil, indicating no value.

### Basic Types {#basic-type}

#### Integer (int) Type {#int-type}

The integer type is 64-bit long, signed, and currently only supports writing integer literals in decimal format, such as `-1`, `0`, `1`, `+19`.

#### Floating-point (float) Type {#float-type}

The floating-point type is 64-bit long, signed, and currently only supports writing floating-point literals in decimal format, such as `-1.00001`, `0.0`, `1.0`, `+19.0`.

#### Boolean (bool) Type {#bool-type}

There are only two Boolean literals: `true` and `false`.

#### String (str) Type {#str-type}

String literals can be enclosed in double or single quotes, and multi-line strings can be written by enclosing the content with triple double quotes or triple single quotes.

- `"hello world"`
- `'hello world'`
- Using `"""` to express multi-line strings

  ```python
  """hello
  world"""
  ```

- Using `'''` to express multi-line strings

  ```python
  '''
  hello
  world
  '''
  ```

### Composite Types {#composite-type}

The map and list types are different from other types; multiple variables can point to the same map or list object, and when assigning, there is no memory copy of the list or map, but rather a reference to the memory address of the map/list value.

#### Map Type {#map-type}

The map type is a key-value structure, and (currently) only strings can be used as keys, with no restrictions on the data type of values.

Its elements in the map can be read and written through index expressions:

```python
a = {
  "1": [1, "2", 3, nil],
  "2": 1.1,
  "abc": nil,
  "def": true
}

# Since a["1"] is a list object, b is now referencing the value of a["1"]
b = a["1"]

"""
At this point a["1"][0] == 1.1
"""
b[0] = 1.1
```

#### List Type {#list-type}

The list type can store any number of values of any type in the list.

Its elements in the list can be read and written through index expressions:

```python
a = [1, "2", 3.0, false, nil, {"a": 1}]

a = a[0] # a == 1
```

## Operators {#operator}

The following are the operators currently supported by Platypus, with higher numerical values indicating higher precedence:

| Precedence | Symbol | Associativity | Description |
|-|-|-|-|
| 1 | `=`  | Right | Assignment; named parameters; lowest precedence |
| 1 | `+=` | Right | Assignment, left operand = left operand + right operand |
| 1 | `-=` | Right | Assignment, left operand = left operand - right operand |
| 1 | `*=` | Right | Assignment, left operand = left operand * right operand |
| 1 | `/=` | Right | Assignment, left operand = left operand / right operand |
| 1 | `%=` | Right | Assignment, left operand = left operand % right operand |
| 2 | `||` | Left | Logical "OR" |
| 3 | `&&` | Left | Logical "AND" |
| 4 | `in` | Left | Check if key is in map; if element is in list; if substring is contained in string |
| 5 | `>=` | Left | Conditional "greater than or equal to" |
| 5 | `>`  | Left | Conditional "greater than" |
| 5 | `!=` | Left | Conditional "not equal to" |
| 5 | `==` | Left | Conditional "equal to" |
| 5 | `<=` | Left | Conditional "less than or equal to" |
| 5 | `<`  | Left | Conditional "less than" |
| 6 | `+`  | Left | Arithmetic "addition" |
| 6 | `-`  | Left | Arithmetic "subtraction" |
| 7 | `*`  | Left | Arithmetic "multiplication" |
| 7 | `/`  | Left | Arithmetic "division" |
| 7 | `%`  | Left | Arithmetic "modulo" |
| 8 | `!`  | Right | Unary operator; logical "NOT"; applicable to all 6 built-in data types |
| 8 | `+`  | Right | Unary operator; positive sign, used to represent positive numbers |
| 8 | `-`  | Right | Unary operator; negative sign, used to indicate negation/negative numbers |
| 9 | `[]` | Left | Subscript operator; can use list subscripts or map keys to retrieve values |
| 9 | `()` | Left | Can change the precedence of operators; function calls |

## Expressions {#expr}

Platypus uses the comma `,` as the expression separator, such as for passing arguments in function calls and separating expressions during the initialization of maps and lists.

In Platypus, expressions can have values, but **statements definitely have no value**, meaning that statements cannot serve as the operands for operators like `=`, whereas expressions can.



### Literal Expressions {#list-expr}

Literals of various data types can serve as expressions, such as integers `100`, `-1`, `0`, floating-point numbers `1.1`, boolean values `true`, `false`, etc.

The following are the ways to write literal expressions for composite types:

- List Literal Expression

```txt
[1, true, "1", nil]
```

- Map Literal Expression

```txt
{
  "a": 1,
  "b": "2",
}
```

### Invocation Expression {#call-expr}

The following is an example of a function call used to determine the number of elements in a list:

```txt
len([1, 3, "5"])
```

### Binary Expression {#binary-expr}

A binary expression consists of a binary operator and left and right operands.

In the current version, the assignment expression is considered a binary expression and has a return value; however, due to potential issues arising from the assignment expression, this syntax will be deprecated in the future in favor of an **assignment statement** syntax.

```python
# 0
2 / 5

# 0.4, the type of the left operand is promoted to a floating-point during calculation
2 / 5.0

# true
1 + 2 * 3 == 7 && 1 <= 2

# Due to the right associativity of the `=` operator, a = (b = 3), a == 3
b = 3
a = b = 3

# Note: Since the assignment expression syntax is about to be deprecated, please replace it with an assignment statement
b = 3
a = b

"a" in [1, "a"]   # true
"def" in "abcdef"  # true
"a" in {"a": 1}  # true
"b" in {"a": 1}  # false

x = 1; y = [1]
x in y  # true
```

### Index Expression {#index-expr}

Index expressions use the `[]` subscript operator to manipulate elements of a list or map.

Index expressions can be used to retrieve, modify, or add elements to a map, and negative numbers can be used for indexing lists.

Syntax example:

```py
a = [1, 2, 3, -1.]
b = {"a": [-1], "b": 2}

a[-1] = -2
b["a"][-1] = a[-1]

# Result
# a: [1,2,3,-2]
# b: {"a":[-2],"b":2}
```

### Parenthesized Expression {#bracket-expr}

Parentheses can change the order of operations among operands in a binary expression but cannot change associativity:

```txt
# 1 + 2 * 3 == 7

(1 + 2) * 3  # == 9
```

## Statements {#stmt}

All expressions in Platypus can be considered value statements. When an expression is terminated with a statement separator `;` or `\n`, it is treated as a statement, such as the following script containing four statements:

```go
len("abc")
1
a = 2; a + 2 * 3 % 2
```

### Value Statement (Expression Statement) {#value-stmt}

When an expression is followed by a statement separator, it can be considered a value statement. Here are four legal statements:

```txt
# A floating-point number as a statement
1.;

# A function call expression as a statement
len("Hello World!"); len({"a": 1})

# An identifier as a statement
abc
```

### Assignment Statement {#assignment-stmt}

Syntax example:

```py
key_a = "key-a"

# Identifier a as the left operand, assigning a list literal to a
a = [1, nil, 3]

# Index expression as the left operand
a[0] = 0
a[2] = {"key-b": "value-b"}
a[2][key_a] = 123
```

### Selection Statement {#select-stmt}

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

Like most programming languages, depending on whether the conditions in `if/elif` are met, the corresponding statement block is entered; if none are met, the `else` branch is entered.

Currently, a condition can be any expression as long as its value is one of the built-in data types. When its value is the default value of the type, the expression evaluates to `false`:

- When the condition is an `int` type value, it is `false` if it is `0`, otherwise `true`.
- When the condition is a `float` type value, it is `false` if it is `0.0`, otherwise `true`.
- When the condition is a `string` type value, it is `false` if it is an empty string `""`, otherwise `true`.
- When the condition is a `bool` type value, the condition is the current value.
- When the condition is a `nil` type value, it is `false`.
- When the condition is a `map` type value, it is `false` if its length is 0, otherwise `true`.
- When the condition is a `list` type value, it is `false` if its length is 0, otherwise `true`.

### Loop Statement {#loop-stmt}

Platypus supports `for` statements and `for in` statements.

The following are two statements that are only allowed within loop statement blocks:

- `continue` statement, does not execute subsequent statements and continues to the next loop iteration.
- `break` statement, ends the loop.

Using a `for` statement may result in an infinite loop, so it should be used cautiously, or replaced with a `for in` statement whenever possible.

```txt
for init-expr; condition; loop-expr {

}
```

```txt
for varb_name in map_value/list_value/string_value  {

}
```

Usage examples:

- Perform 10 loop iterations using `for`:

  ```py
  for a = 0; a < 10; a = a + 1 {
    
  }
  ```

- Traverse all elements of a list using `for in`:

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

- Traverse all keys of a map using `for in`:

  ```py
  d = 0
  map_a = {"a": 1, "b":2}
  for x in map_a {
    d = d + map_a[x]
  }
  ```

- Traverse all characters of a string using `for in`:




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
