# TSV to CSV conversion

Nothing complicated happens here.

TSV is a much better format than CSV. We take the _C_ literally: the
separator is `,`, if it was a semicolon `;`, then the name would be SSV, wouldn't it.

The TSV rules we use are:

1. no quoting
    - quotes are removd
    - quoting is harmless (not an error)
2. TABs cannot be part of a field
    - this has never been necessary
    - normal spreadsheet software doesn't even let you type a TAB (TAB selects the next field)
    - trying to have a TAB in a field will make an inconsistent CSV file

## Why even make a CSV file?

If you received a CSV file from someone, then it's better to use `csvquote`.

But, if you have a TSV file, then some software will still require the input to be CSV, rather than TSV (e.g. GNU recutils).

This means that a field that contains a comma needs to be converted to something else, before the tabs are converted to commas.

Similar to various `csvquote` implementations, we convert `,` to
`\037` which is the lowest precendence, non-printable, ascii separator
code (36, 35, 34 would have been fine as well).

## Examples

```sh
./tsv2csv < file.tsv | csv2rec      # from GNU recutils
```

and in reverse

```sh
./tsv2csv --undo < file.csv > file.tsv
```

The conversion to TSV also removes all quotes, as TSV does not require field quoting.

Or again with rec files:

```sh
./tsv2csv < file.tsv | csv2rec | rec2csv | ./tsv2csv --undo
```

# This is just `tr`

this script just calls `tr`, but this way I don't need to remember
`\037` and other features can be added later, if needed.
