servo:
	ansible-playbook servo.yaml --vault-password-file .vault-password

homebot:
	ansible-playbook homebot.yaml --vault-password-file .vault-password

proxmox:
	ansible-playbook proxmox.yaml --vault-password-file .vault-password

tailscale:
	ansible-playbook tailscale.yaml --vault-password-file .vault-password

deploy:
	ansible-playbook deploy.yaml --vault-password-file .vault-password

update:
	ansible-playbook update.yaml

test:
	ansible-playbook test.yaml

encrypt:
	ansible-vault encrypt --vault-password-file .vault-password vars/vault.yaml

decrypt:
	ansible-vault decrypt --vault-password-file .vault-password vars/vault.yaml

gitinit:
	@./git-init.sh
	@echo "ansible vault pre-commit hook installed"
	@echo "don't forget to create a .vault-password too"
