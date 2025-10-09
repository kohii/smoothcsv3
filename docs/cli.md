# SmoothCSV Command Line Interface Specification

## Overview
The `smoothcsv` command provides a powerful way to open and manipulate CSV files from the terminal, similar to VSCode's `code` command but optimized for CSV editing workflows.

## Basic Syntax
```bash
smoothcsv [options] [path ...]
```

## Opening Files

### Basic File Opening
```bash
# Open a single file
smoothcsv data.csv

# Open multiple files in tabs
smoothcsv data1.csv data2.csv data3.csv

# Open from stdin
cat data.csv | smoothcsv -
```

Note: You cannot specify location in regular file arguments. Use the `--goto` flag instead.

### Location Specification

Use the `--goto` flag to open a file and jump to a specific location:

```bash
# Jump to specific row
smoothcsv --goto data.csv:5

# Jump to specific cell (row:column)
smoothcsv --goto data.csv:10:3

# Select row range
smoothcsv --goto data.csv:1-100

# Select cell range
smoothcsv --goto data.csv:1:1-10:5

# Short form
smoothcsv -g data.csv:10:3
```

## CSV Format Options

Note: SmoothCSV will automatically detect the CSV format from the file contents. You can use the following options to override the detection.

### Delimiter Configuration
```bash
# Using common aliases
smoothcsv data.csv --delimiter comma
smoothcsv data.csv --delimiter tab
smoothcsv data.csv --delimiter semicolon
smoothcsv data.csv --delimiter pipe
smoothcsv data.csv --delimiter space

# Using literal character
smoothcsv data.csv --delimiter "|"
smoothcsv data.csv --delimiter ";"

# Short form
smoothcsv data.csv -d tab
```

### Quote Configuration
```bash
# Quote character
smoothcsv data.csv --quote double    # Use double quotes
smoothcsv data.csv --quote single    # Use single quotes
smoothcsv data.csv --quote none      # No quotes

# Using literal character
smoothcsv data.csv --quote "'"

# Short form
smoothcsv data.csv -q double

# Quote behavior
smoothcsv data.csv --quote-mode always # Quote always
smoothcsv data.csv --quote-mode minimal # Quote only when needed

# Short form
smoothcsv data.csv --qm minimal

# Combined short form
smoothcsv data.csv -q double --qm minimal
```

### Encoding
```bash
smoothcsv data.csv --encoding utf8
smoothcsv data.csv -e shiftjis
```

### Header and Display Options

#### Header Configuration
```bash
# Configure header rows (semantic meaning)
smoothcsv data.csv --header-rows 1        # First row is header (default: auto-detect)
smoothcsv data.csv --header-rows 2        # First 2 rows are headers
smoothcsv data.csv --header-rows 0        # No header rows

# Configure header columns (semantic meaning)
smoothcsv data.csv --header-columns 1     # First column is header
smoothcsv data.csv --header-columns 2     # First 2 columns are headers
smoothcsv data.csv --header-columns 0     # No header columns (default)

# Shorthand for header configuration
smoothcsv data.csv --header               # Equivalent to --header-rows 1
smoothcsv data.csv --no-header            # Shorthand for --header-rows 0
```

## Window Management

### New Window
```bash
# Open in new window
smoothcsv --new-window data.csv
smoothcsv -n data.csv

# Reuse existing window (default)
smoothcsv --reuse-window data.csv
smoothcsv -r data.csv
```

## Integration Features

### Wait for Close
```bash
# Wait for file to be closed before returning
smoothcsv data.csv --wait
smoothcsv data.csv -w

# Useful in scripts
smoothcsv data.csv --wait && echo "Editing complete"
```

## Utility Commands

### Version and Help
```bash
# Show version
smoothcsv --version
smoothcsv -v

# Show help
smoothcsv --help
smoothcsv -h
```

## Examples

### Common Workflows

```bash
# Edit with specific Japanese encoding
smoothcsv japanese_data.csv -e shiftjis

# Open multiple files with same format
smoothcsv *.csv --new-window
```

### Script Integration

```bash
#!/bin/bash
# Edit CSV and wait for completion
smoothcsv data.csv --wait

# Check if file was modified
if [ data.csv -nt backup.csv ]; then
    echo "File was modified"
    cp data.csv backup.csv
fi
```

## URL Protocol Integration

The command line tool seamlessly integrates with the URL protocol:

```bash
# These are equivalent
smoothcsv --goto data.csv:5:10 --delimiter tab
smoothcsv "smoothcsv://file/$(pwd)/data.csv:5:10?delimiter=tab"
```

## Exit Codes

- `0` - Success
- `1` - General error
- `2` - Invalid command line arguments

## Notes

- All row and column indices are 1-based to match the GUI display
- Multiple files open in tabs within the same window by default
- File paths can be relative or absolute
- On Windows, both forward slashes and backslashes are supported
