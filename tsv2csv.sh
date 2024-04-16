#!/bin/sh

tsv_to_csv () {
	tr ',' '\037' | tr '\t' ','
}

csv_to_tsv () {
	tr ',' "\t" | tr '\037' ',' | tr -d \"
}

if [ -t 0 ]; then
	echo "Usage: $0 < file.tsv > file.csv"
else
	while [ "$#" -gt 0 ]; do
		case $1 in
		-r|--reverse|-u|--undo) csv_to_tsv; exit 0;;
		-f|--forward) tsv_to_csv; exit 0;;
		*) echo "unknown option: $1"; shift;;
		esac
	done
	tsv_to_csv
fi
