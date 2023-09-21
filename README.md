# Run Docker Compose on a Remote Server through SSH with GitHub Actions

This GitHub action allows you to run `docker compose` on a remote server through an SSH connection. The process involves compressing the workspace into a file, transferring it via SSH to the remote server, and then running the `docker compose up -d` command.

This action stands out because it doesn't require the use of unknown Docker images. Instead, the action is built from a Dockerfile that uses the `alpine` base.

## Inputs

- `ssh_password` - It is recommended to keep this password secure in GitHub secrets.
- `ssh_host` - SSH Host Name.
- `ssh_port` - Remote port, default is 22.
- `ssh_user` - Remote username with permissions to access Docker.
- `docker_compose_prefix` - Project prefix passed to `docker-compose`. Each Docker container will be named with this prefix.
- `docker_compose_filename` - Path to the docker-compose file in the repository.
- `use_stack` - Use 'docker stack' instead of 'docker-compose'.
- `pull` - Update images when performing a pull, default is `false`.

# Usage Example

Let's assume we have a repository containing only a `docker-compose` file, and we have a remote server based on Ubuntu with Docker and Docker Compose installed.

Follow these steps:

1. Add the password, username, port and host to the repository secrets. Suppose the names of the secrets are `SSH_PASSWORD`, `SSH_USER`, `SSH_PORT` and `SSH_HOST`.

2. Configure the GitHub Actions workflow (for example, `.github/workflows/main.yml`):

```
name: Deploy

on:
  push:
    branches: [ master ]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - uses: TFSM00/ssh-docker-compose-action@main
      name: Remote Deployment with Docker-Compose
      with:
        ssh_host: ${{ secrets.SSH_HOST }}
        ssh_password: ${{ secrets.SSH_PASSWORD }}
        ssh_user: ${{ secrets.SSH_USER }}
        ssh_port: ${{ secrets.SSH_PORT }}
        docker_compose_prefix: example_com
        pull: true # Update images when pulling
```