# SQL in Row Filter

SmoothCSV allows you to filter rows using SQL WHERE clause syntax, providing a powerful way to query your CSV data.

## Getting Started

To access the filter query input:

- Use keyboard shortcut: `Ctrl+Shift+F` (macOS: `Cmd+Shift+F`)
- Open Command Palette and search for "filter"
- Select `Grid` > `Filter` from the menubar

## Query Syntax

The filter uses SQL WHERE clause syntax with some limitations:

- Write only the condition part that would follow a WHERE clause
- No subqueries
- No window functions
- No aggregate functions

## Referencing Columns

- Column names can be referenced in two ways:
  - Using header row values when a header row is specified
    - Use double quotes for names with special characters
    - Example: `"First Name" LIKE 'John%'`
  - Using default names (`c1`, `c2`, ...) when no header row is present
    - Example: `c1 > 1000 AND c2 = 'Active'`

## Data Types

Supported types:

- `string` (alias: `text`, `varchar`)
- `number` (alias: `double precision`, `float`)
- `boolean`
- `bigint`
- `null`
- `date`
- `time`
- `timestamp`
- `interval`

Notes:

- All cell values are initially treated as `string`
- Type coercion follows JavaScript-like rules for primitive types:
  - `1 = true` → `true`
  - `'1' = 1` → `true`
  - `'' = 0` → `true`
  - `1 + true` → `2`
- No implicit type coercion is performed for `date`, `time`, `timestamp`, and `interval` types
  - Use `CAST` or `TRY_CAST` to convert strings to these types

Use `CAST` or `TRY_CAST` for explicit type conversion:

```sql
CAST('123' AS bigint) -- returns 123
CAST('12.3' AS double precision) -- returns 12.3
CAST('abc' AS bigint) -- error
TRY_CAST('abc' AS bigint) -- returns null
CAST('2024-03-14' AS date) -- returns date
CAST('15:30:00' AS time) -- returns time
CAST('2024-03-14 15:30:00' AS timestamp) -- returns timestamp
```

### Date/Time/Interval Literal Syntax

#### Date

- ISO format: `DATE 'YYYY-MM-DD'`
- Example: `DATE '2024-03-14'`

#### Time

- 24-hour format: `TIME 'HH:MM:SS[.fraction]'`
- Example: `TIME '15:30:00'`, `TIME '15:30:00.123'`

#### Timestamp

- Combined date and time: `TIMESTAMP 'YYYY-MM-DD HH:MM:SS[.fraction]'`
- Example: `TIMESTAMP '2024-03-14 15:30:00'`

#### Interval

- Format: `INTERVAL 'quantity' leading_field [to last_field]`
- Supported units: `year`, `month`, `day`, `hour`, `minute`, `second`
- Example: `INTERVAL '1-2' year to month`, `INTERVAL '1 2:30' day to minute`

### Numeric Literal Inference

- If a numeric literal is all digits and outside the range of `number` type in JavaScript (i.e. `-9007199254740991` to `9007199254740991`), interpret it as `bigint`.
- Otherwise, interpret it as `number`.

```
123 → number
12345678901234567890 → bigint
12345678901234567890.0 → number
```

## Available Functions

### String Functions

| Function | Description | Example |
|----------|-------------|---------|
| `LENGTH(str)` | String length | `LENGTH(name) > 5` |
| `LOWER(str)` | Convert to lowercase | `LOWER(status) = 'active'` |
| `UPPER(str)` | Convert to uppercase | `UPPER(code) = 'ABC'` |
| `TRIM(str)` | Remove whitespace | `TRIM(description) != ''` |
| `SUBSTRING(str, start[, length])` | Extract substring | `SUBSTRING(name, 1, 3) = 'Joe'` |
| `CONCAT(str1, str2, ...)` | Join strings | `CONCAT(firstName, ' ', lastName)` |
| `REPLACE(str, from, to)` | Replace text | `REPLACE(email, '@old.com', '@new.com')` |

### Numeric Functions

| Function | Description | Example |
|----------|-------------|---------|
| `ABS(num)` | Absolute value | `ABS(balance) > 1000` |
| `CEIL(num)` | Round up | `CEIL(price) = 100` |
| `FLOOR(num)` | Round down | `FLOOR(rating) = 4` |
| `ROUND(num[, precision])` | Round number | `ROUND(amount, 2) = 99.99` |
| `POWER(base, exp)` | Power operation | `POWER(num, 2) > 100` |
| `SQRT(num)` | Square root | `SQRT(area) < 10` |
| `MOD(num, divisor)` | Remainder | `MOD(id, 2) = 0` |
| `TRUNC(num[, precision])` | Truncate decimals | `TRUNC(price, 2)` |

### Conditional Functions

| Function | Description | Example |
|----------|-------------|---------|
| `COALESCE(val1, val2, ...)` | First non-null value | `COALESCE(nickname, name, 'Unknown')` |
| `NULLIF(val1, val2)` | Null if equal | `NULLIF(status, 'N/A')` |
