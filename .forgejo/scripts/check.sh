#!/usr/bin/env bash
# Lint/syntax-check dotfiles. Usage: check.sh [FILE...]  (default: all tracked files)
# Used by both the Forgejo workflow and the pre-commit hook.
# In CI (CI=true) a missing tool is an error; locally it's only a warning.
set -uo pipefail

cd "$(git rev-parse --show-toplevel)" || exit 1
here=.forgejo/scripts

if [ $# -gt 0 ]; then
	mapfile -t files < <(printf '%s\n' "$@")
else
	mapfile -t files < <(git ls-files)
fi

failed=0
fail() { printf '\e[31mFAIL\e[0m %s\n' "$*"; failed=1; }
ok() { printf '\e[32m ok \e[0m %s\n' "$*"; }

need() {
	command -v "$1" >/dev/null && return 0
	if [ "${CI:-}" = true ]; then fail "$1 not installed"; else
		printf '\e[33mskip\e[0m %s not installed\n' "$1"; fi
	return 1
}

# Pick files by extension, ignoring archived stuff and deleted paths.
pick() {
	local f
	for f in "${files[@]}"; do
		[ -f "$f" ] || continue
		case "$f" in */.old/* | .old/* | *.old | *.bak) continue ;; esac
		for ext in "$@"; do
			case "$f" in *."$ext") printf '%s\n' "$f"; break ;; esac
		done
	done
}

# ── Things that should never be committed ────────────────────────────
bad=()
for f in "${files[@]}"; do
	case "${f##*/}" in
	.zcompdump* | *_history | .histfile | .env | *.pem | *.key | id_rsa | id_ed25519 | id_ecdsa | *.kdbx | wallet*.keys)
		bad+=("$f") ;;
	esac
done
if [ ${#bad[@]} -gt 0 ]; then
	fail "files that shouldn't be tracked (git rm --cached them):"
	printf '       %s\n' "${bad[@]}"
else
	ok "no forbidden files"
fi

# ── Shell ────────────────────────────────────────────────────────────
mapfile -t sh < <(pick sh bash)
if [ ${#sh[@]} -gt 0 ] && need shellcheck; then
	if shellcheck -S warning "${sh[@]}"; then ok "shellcheck (${#sh[@]})"; else fail shellcheck; fi
fi

# ── Lua (Hyprland, Neovim) ───────────────────────────────────────────
mapfile -t lua < <(pick lua)
if [ ${#lua[@]} -gt 0 ]; then
	luac=$(command -v luac || command -v luac5.4 || true)
	if [ -n "$luac" ]; then
		lua_ok=1
		for f in "${lua[@]}"; do "$luac" -p "$f" || lua_ok=0; done
		if [ $lua_ok = 1 ]; then ok "lua syntax (${#lua[@]})"; else fail "lua syntax"; fi
	else
		need luac
	fi
fi

# ── JSON / JSONC / TOML ──────────────────────────────────────────────
mapfile -t data < <(pick json jsonc toml)
if [ ${#data[@]} -gt 0 ] && need python3; then
	if python3 "$here/check_data.py" "${data[@]}"; then ok "json/toml (${#data[@]})"; else fail "json/toml"; fi
fi

# ── Python ───────────────────────────────────────────────────────────
mapfile -t py < <(pick py)
if [ ${#py[@]} -gt 0 ] && need python3; then
	if python3 -c 'import ast, sys
for f in sys.argv[1:]: ast.parse(open(f, "rb").read(), f)' "${py[@]}"; then
		ok "python syntax (${#py[@]})"
	else
		fail "python syntax"
	fi
fi

exit $failed
