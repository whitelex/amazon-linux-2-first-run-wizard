# Amazon Linux 2 Setup Script

## Description

This script automates the setup process for an Amazon Linux 2 instance, allowing you to change passwords, create a new sudo user, install GitHub CLI (gh), and enable password authentication for SSH access.

## Features

- Change root password
- Change ec2-user password
- Create a new sudo user
- Install GitHub CLI (gh)
- Run a GitHub setup wizard
- Enable password authentication for SSH access

## Prerequisites

- An Amazon Linux 2 instance
- Root or sudo access to the instance

## Usage

1. Connect to your Amazon Linux 2 instance using SSH.
2. Download the `setup.sh` script to your instance.
3. Make the script executable by running the following command:

`chmod +x setup.sh`

4. Run the script as root or with sudo privileges:

`sudo ./setup.sh`

5. Follow the prompts to change passwords, create a new sudo user, install GitHub CLI (gh), and enable password authentication for SSH access.

**Note:** Enabling password authentication for SSH access may have security implications. Ensure that you have a strong password and consider the associated risks before enabling it.

After the script completes execution, your Amazon Linux 2 instance will be configured according to your selections.

## License

This script is licensed under the [MIT License](LICENSE).