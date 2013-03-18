#!/bin/bash

echo -n "$0: "

THIS_DIR=$(cd $(dirname "$BASH_SOURCE"); pwd)
cd $THIS_DIR
ACTUAL_OUTFILE=$(mktemp -t actual)
EXPECTED_OUTFILE=$(mktemp -t expected)

cat *.html > "$EXPECTED_OUTFILE"

../src/yaml2html.coffee *.yaml > "$ACTUAL_OUTFILE"

DIFF=$(diff "$EXPECTED_OUTFILE" "$ACTUAL_OUTFILE")
rm "$EXPECTED_OUTFILE" "$ACTUAL_OUTFILE"

if [ -n "$DIFF" ]
then
    echo failed:
    echo "$DIFF"
    exit 1
fi
echo ok

