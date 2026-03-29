#!/usr/bin/env bash
#
# Sets up git pre-commit hook to ensure that files with sensitive content
# are encrypted prior to commit.
#
# Credit to Nick Busey from HomelabOS:
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355
#
set -e

vaults=(
  "group_vars/all/vault.yaml"
  "host_vars/servo/vault.yaml"
  "host_vars/tailscale/vault.yaml"
)

precommit=".git/hooks/pre-commit"

# Build the pre-commit hook script
hook="#!/usr/bin/env bash\n"
for vault in "${vaults[@]}"; do
  hook+="if ( git show :${vault} | grep -q \"\\\$ANSIBLE_VAULT;\" ); then\n"
  hook+="  echo \"\033[38;5;108m${vault} encrypted. Safe to commit.\033[0m\"\n"
  hook+="else\n"
  hook+="  echo \"\033[38;5;208m${vault} not encrypted! Run 'make encrypt' and try again.\033[0m\"\n"
  hook+="  exit 1\n"
  hook+="fi\n"
done

if [ -d .git/ ]; then
	rm -f $precommit
	echo -e "$hook" > $precommit
fi

chmod +x $precommit
