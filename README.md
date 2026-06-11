# economycomfort/infra

Provides a taxonomy for tracking changes to services within my home lab, and an excuse to learn 
 how [ansible](https://github.com/ansible/ansible) works.

Thanks to [Alex Kretzschmar](https://github.com/ironicbadger)'s various blog posts about using Ansible.

## Getting started

- Install git pre-commit hook:
  `make gitinit`

- Create a `.vault-password` file containing the Ansible Vault password (this file is gitignored).

- Install Galaxy roles and collections:
  ```bash
  ansible-galaxy install -r requirements.yaml
  ansible-galaxy collection install -r requirements.yaml
  ```

Edit away.

## AI-assisted administration

This repo includes an `AGENTS.md` file for AI coding agents. It captures the repo layout, common commands, and vault handling expectations for tasks like reviewing playbooks, adding roles, or refactoring variables.

Run `make encrypt` before committing any vault changes.

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Licensed under the MIT License.
See [LICENSE](LICENSE) file.
