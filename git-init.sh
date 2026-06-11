#!/usr/bin/env bash
#
# Sets up git pre-commit hook to ensure that files with sensitive content
# are encrypted prior to commit.
#
# Credit to Nick Busey from HomelabOS:
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355
#
set -e

precommit=".git/hooks/pre-commit"

if [ -d .git/ ]; then
  cat > "$precommit" <<'HOOK'
#!/usr/bin/env bash
#
# Prevent plaintext Ansible vault files from being committed.
#
set -e

vaults=()
while IFS= read -r path; do
  case "$path" in
    group_vars/*/vault.yaml|host_vars/*/vault.yaml)
      vaults+=("$path")
      ;;
  esac
done < <(git diff --cached --name-only --diff-filter=ACMR)

for vault in "${vaults[@]}"; do
  if git show ":${vault}" | grep -q '^\$ANSIBLE_VAULT;'; then
    printf '\033[38;5;108m%s encrypted. Safe to commit.\033[0m\n' "$vault"
  else
    printf '\033[38;5;208m%s not encrypted! Run '"'"'make encrypt'"'"' and try again.\033[0m\n' "$vault"
    exit 1
  fi
done
HOOK
fi

chmod +x "$precommit"
