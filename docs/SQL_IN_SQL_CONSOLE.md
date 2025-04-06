# SQL Console (Experimental)

SmoothCSV provides a powerful SQL query interface for CSV files through its SQL Console feature. This feature leverages [DuckDB](https://duckdb.org/) as its underlying SQL engine, enabling you to perform complex data analysis directly on your CSV files.

Note: This feature is experimental and the syntax is subject to change.

## Accessing the SQL Console

There are three ways to open the SQL Console:

- Via Command Palette: Search for "SQL console"
- Via Menu Bar: Navigate to `File` > `New SQL Console`
- Via `Open in SQL Console` in the filter widget

## Writing SQL Queries

### Query Syntax Overview

The SQL Console supports DuckDB's SQL syntax.

### Table References

You can reference your CSV files in queries using the `@` prefix syntax:

```sql
-- For files with a specific path
SELECT * FROM '@file:/path/to/file.csv';

-- For untitled/unsaved files
SELECT * FROM '@untitled:Untitled-1';
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
   SELECT "First Name", Age FROM '@file:/data.csv'
   WHERE "First Name" LIKE 'John%';
   ```

2. When no header row exists:
   - Use default column names: `c1`, `c2`, etc.
   ```sql
   SELECT c1, c2 FROM '@file:/data.csv'
   WHERE c1 > 1000;
   ```

### Data Type Handling

By default, all columns are treated as strings (VARCHAR). For numerical or date operations, explicit type casting is required:

## Alternative: DuckDB Native CSV Reader

For advanced use cases, you can utilize DuckDB's native CSV reader:

```sql
-- Simple syntax
SELECT * FROM '/path/to/file.csv';

-- Extended syntax with read_csv function
SELECT * FROM read_csv('/path/to/file.csv');
```

For detailed information about DuckDB's CSV import capabilities, refer to the [official DuckDB CSV documentation](https://duckdb.org/docs/stable/data/csv/overview.html).

### Feature Comparison

#### SmoothCSV Protocol (`@file:` or `@untitled:`)
- ✓ Supports access to unsaved files
- ✓ Uses `c1`, `c2`, etc. for unnamed columns
- ✓ Automatically infers CSV format and header settings
- ✓ Matches SmoothCSV's file opening behavior

#### DuckDB Native Reader
- ✓ Requires saved files
- ✓ Uses `column0`, `column1`, etc. for unnamed columns
- ✓ Supports custom column name specification
- ✓ Provides additional import options
