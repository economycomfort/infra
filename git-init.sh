#!/usr/bin/env bash
#
# Sets up git pre-commit hook to ensure that files with sensitive content
# is encrypted prior to commit.
#
# Credit to Nick Busey from HomelabOS:
# https://gitlab.com/NickBusey/HomelabOS/-/issues/355
#
set -e

vault="vars/vault.yaml"
precommit=".git/hooks/pre-commit"

info=$(cat <<EOT
if ( git show :${vault} | grep -q "\$ANSIBLE_VAULT;" ); then
  echo "\033[38;5;108mVault Encrypted. Safe to commit.\033[0m"
else
  echo "\033[38;5;208mVault not encrypted! Run 'make encrypt' and try again.\033[0m"
  exit 1
fi
EOT
)

if [ -d .git/ ]; then
	rm $precommit
	echo "$info" >> $precommit
fi

chmod +x $precommit
