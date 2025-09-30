# Opening files with URLs

## Syntax
```
smoothcsv://file/path/to/file.csv[:location][?params]
```

## Components

### Path with Location
- **File Path**: `/path/to/file.csv`
- **Location** (optional): `:location` - Go to a specific cell or row after opening the file

### Location Formats
- `5` - Row 5
- `1:2` - Cell at row 1, column 2  
- `1-5` - Rows 1-5
- `1:2-10:20` - Cell range from (1,2) to (10,20)

*Coordinates are 1-indexed*

### Query Parameters
All parameters are optional and case-insensitive:

- `delimiter` - Field separator
  - Aliases: `comma`, `tab`, `semicolon`, `pipe`, `space`
  - Or single character literal
- `quote` - Quote character
  - Aliases: `double` (""), `single` ('), `none` ("")
  - Or single character literal  
- `quotemode` - When to quote fields
  - Values: `minimal`, `always`, `never`
- `encoding` - Character encoding (e.g., `UTF-8`)

## Examples
```
smoothcsv://file/data.csv
smoothcsv://file/data.csv:5
smoothcsv://file/data.csv:1:2-10:20
smoothcsv://file/data.csv?delimiter=semicolon&encoding=UTF-8
smoothcsv://file/data.csv:5?delimiter=tab&quote=double
smoothcsv://file/c:/path/to/file.csv
```
