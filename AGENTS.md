# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Overview

Ansible-based infrastructure-as-code for a home lab. Manages 5 hosts: proxmox (hypervisor), servo (ZFS storage server), homebot (home automation), sandbox (testing), and tailscale (VPN exit node). Inventory is in `hosts.yaml`.

## Common Commands

```bash
make servo          # Deploy to storage server
make homebot        # Deploy to home automation VM
make proxmox        # Deploy to Proxmox hypervisor
make sandbox        # Deploy to sandbox VM
make tailscale      # Deploy to Tailscale exit node
make update         # Update SSH keys and packages on all hosts
make test           # Run test playbook
make encrypt        # Encrypt all vault files (must do before committing)
make decrypt        # Decrypt all vault files for editing
make gitinit        # Install pre-commit hook that prevents committing decrypted vault
```

`vault_password_file` is set in `ansible.cfg`, so all playbook invocations pick it up automatically.

## Architecture

- **Per-host playbooks** at the repo root (`servo.yaml`, `homebot.yaml`, etc.) — each defines roles and tasks for one host
- **Custom roles** in `roles/` prefixed with `dab-` (dotfiles, gitrepos, motd, mounts, networking, proxmox, tailscale, ups)
- **Galaxy roles** in `galaxy/roles/` (geerlingguy.docker, geerlingguy.nfs, geerlingguy.ntp, grog.package, etc.) — installed via `ansible-galaxy install -r requirements.yaml`
- **Variables**: `group_vars/all/` (shared config + global vault), `host_vars/` (per-host vars and per-host vaults)
- **Templates** in `templates/servo/` (sanoid, syncoid, samba configs) and within roles

## Vault / Secrets

Secrets are distributed across vault files that auto-load via Ansible's directory conventions:
- `group_vars/all/vault.yaml` — global secrets
- `host_vars/servo/vault.yaml` — Samba/pihole secrets
- `host_vars/tailscale/vault.yaml` — Tailscale auth key

The password file is `.vault-password` (gitignored). A pre-commit hook checks all vault files are encrypted. Always `make encrypt` before committing.

## Key Infrastructure Details

- **servo**: Ubuntu, ZFS with two pools (`tank` for bulk, `fast` for performance), Sanoid snapshots, Syncoid replication, Samba shares, NFS exports, Docker
- **proxmox**: Debian/Proxmox VE, IOMMU passthrough, cloud-init VM templates, config backup via systemd timer
- **homebot/sandbox**: Debian VMs with Docker
- **tailscale**: Debian, IP forwarding, Tailscale exit node with advertised routes
