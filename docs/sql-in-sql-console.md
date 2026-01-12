# SQL Console

SmoothCSV provides a powerful SQL query interface for CSV files through its SQL Console feature. This feature leverages SQLite as its underlying SQL engine, enabling you to perform complex data analysis directly on your CSV files.

## Accessing the SQL Console

There are three ways to open the SQL Console:

- Via Command Palette: Search for "SQL console"
- Via Menu Bar: Navigate to `File` > `New SQL Console`
- Via `Open in SQL Console` in the filter widget

## Writing SQL Queries

### Query Syntax Overview

The SQL Console supports SQLite's SQL syntax.

### Table References

You can reference CSV files in queries using several formats:

```sql
-- Direct file path (simplest)
SELECT * FROM "/path/to/file.csv";

-- file:// URL format
SELECT * FROM "file:///path/to/file.csv";

-- @file: prefix syntax (legacy, still supported)
SELECT * FROM "@file:/path/to/file.csv";

-- For untitled/unsaved files
SELECT * FROM "@untitled:Untitled-1";
```

The system attempts to locate files in the following order:
1. Currently opened files in the editor
2. Files in the specified filesystem path

### Column References

Column names in queries can be specified in two ways:

1. When header row is present:
   - Use the actual header values
   - Enclose names with special characters in double quotes
   ```sql
   SELECT "First Name", Age FROM "@file:/data.csv"
   WHERE "First Name" LIKE 'John%';
   ```

2. When no header row exists:
   - Use default column names: `c1`, `c2`, etc.
   ```sql
   SELECT c1, c2 FROM "@file:/data.csv"
   WHERE c1 > 1000;
   ```

### Data Type Handling

SQLite features dynamic typing, which means it can automatically convert between text and numeric values as needed. This makes it very convenient for working with CSV data, as you can use numeric operations directly on numeric-looking text values:

```sql
-- Price column contains text values like "1000", "1500", etc.
SELECT 
  Price * 1.1 AS price_with_tax,
  COUNT(*) AS count
FROM "@file:/data.csv"
WHERE Price > 1000
GROUP BY Category;
```
