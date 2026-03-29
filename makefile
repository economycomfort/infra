servo:
	ansible-playbook servo.yaml

homebot:
	ansible-playbook homebot.yaml

proxmox:
	ansible-playbook proxmox.yaml

sandbox:
	ansible-playbook sandbox.yaml

tailscale:
	ansible-playbook tailscale.yaml

deploy:
	ansible-playbook deploy.yaml

update:
	ansible-playbook update.yaml

test:
	ansible-playbook test.yaml

encrypt:
	ansible-vault encrypt group_vars/all/vault.yaml host_vars/servo/vault.yaml host_vars/tailscale/vault.yaml

decrypt:
	ansible-vault decrypt group_vars/all/vault.yaml host_vars/servo/vault.yaml host_vars/tailscale/vault.yaml

gitinit:
	@./git-init.sh
	@echo "ansible vault pre-commit hook installed"
	@echo "don't forget to create a .vault-password too"
