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

## Claude Code

This repo includes a `CLAUDE.md` file for use with [Claude Code](https://claude.ai/code). Useful for tasks like reviewing playbooks, adding new roles, or refactoring variables. Run `make encrypt` before committing — Claude cannot do this for you since it requires the vault password.

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Licensed under the MIT License.
See [LICENSE](LICENSE) file.