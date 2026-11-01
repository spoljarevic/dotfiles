#!/usr/bin/env python3
"""Syntax-check JSON, JSONC and TOML files. Usage: check_data.py FILE..."""

import json
import re
import sys

try:
    import tomllib
except ModuleNotFoundError:  # Python < 3.11
    tomllib = None


def strip_jsonc(text):
    """Remove // and /* */ comments outside of strings, then trailing commas."""
    out, i, n = [], 0, len(text)
    while i < n:
        c = text[i]
        if c == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            out.append(text[i : j + 1])
            i = j + 1
        elif text.startswith("//", i):
            i = text.find("\n", i)
            i = n if i == -1 else i
        elif text.startswith("/*", i):
            end = text.find("*/", i + 2)
            if end == -1:
                raise ValueError("unterminated /* comment")
            out.append("\n" * text.count("\n", i, end))  # keep line numbers
            i = end + 2
        else:
            out.append(c)
            i += 1
    return re.sub(r",(\s*[}\]])", r"\1", "".join(out))


def check(path):
    with open(path, "rb") as f:
        raw = f.read()
    if path.endswith(".toml"):
        if tomllib is None:
            print(f"skip {path}: tomllib needs Python 3.11+", file=sys.stderr)
            return True
        tomllib.loads(raw.decode())
    else:
        # Many apps (Zed, VS Code, fastfetch) accept comments in plain .json too.
        json.loads(strip_jsonc(raw.decode()))
    return True


def main(paths):
    ok = True
    for path in paths:
        try:
            check(path)
        except Exception as e:  # noqa: BLE001 - report any parse failure
            print(f"{path}: {e}", file=sys.stderr)
            ok = False
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
