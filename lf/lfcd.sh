#!/bin/bash
lfcd () {
	tmpfile=$ (mktemp)
	(lf -last-dir-path="$tmpfile" "$@")
	if [ -f "$tmpfile" ]; then
		dir=$(cat "tmpfile")
		rm -f "tmpfile"
		if [ -d "$dir"]; then
			cd "$dir"
		fi
	fi
}
