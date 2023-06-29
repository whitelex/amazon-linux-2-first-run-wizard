#!/bin/bash

# Function to change SSH access by enabling password authentication
change_ssh_access() {
  echo "Enabling password authentication for SSH access..."
  sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
  sudo service sshd restart
  echo "Password authentication enabled for SSH access."
}

# Change root password
echo "Enter the new root password:"
read -s root_password
echo "Changing root password..."
echo "root:$root_password" | sudo chpasswd

# Change ec2-user password
echo "Enter the new ec2-user password:"
read -s ec2user_password
echo "Changing ec2-user password..."
echo "ec2-user:$ec2user_password" | sudo chpasswd

# Create a new sudo user
echo "Would you like to create a new sudo user? (y/n)"
read -r create_sudo_user

if [[ $create_sudo_user =~ ^[Yy]$ ]]; then
  echo "Enter the username for the new sudo user:"
  read -r sudo_username

  echo "Enter the password for the new sudo user:"
  read -s sudo_password

  echo "Creating new sudo user: $sudo_username"
  sudo useradd -m -G wheel "$sudo_username"
  echo "$sudo_username:$sudo_password" | sudo chpasswd

  # Add the sudo user to the wheel group
  echo "Adding $sudo_username to the wheel group"
  sudo usermod -aG wheel "$sudo_username"
fi

# Install gh
echo "Would you like to install GitHub CLI? (y/n)"
read -r install_gh

if [[ $install_gh =~ ^[Yy]$ ]]; then
  echo "Installing gh..."
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo yum install -y gh
  sudo yum update gh

  # Create gh_setup.sh
  echo "Creating gh_setup.sh..."
  echo '#!/bin/bash' > gh_setup.sh
  echo 'echo "Launching gh auth login..."' >> gh_setup.sh
  echo 'gh auth login' >> gh_setup.sh
  echo 'echo "Enter the repository URL to clone:"' >> gh_setup.sh
  echo 'read -r repo_url' >> gh_setup.sh
  echo 'echo "Cloning the repository..."' >> gh_setup.sh
  echo 'gh repo clone "$repo_url"' >> gh_setup.sh
  chmod +x gh_setup.sh

  echo "gh_setup.sh created and made executable."

  echo "Do you want to run gh_setup.sh (GitHub Wizard)? (y/n)"
  read -r run_gh_setup

  if [[ $run_gh_setup =~ ^[Yy]$ ]]; then
    echo "Running gh_setup.sh (GitHub Wizard)..."
    ./gh_setup.sh
  fi
fi

# Change SSH access
echo "Would you like to change SSH access by enabling password authentication? (y/n)"
read -r change_ssh

if [[ $change_ssh =~ ^[Yy]$ ]]; then
  change_ssh_access
fi

echo "Script execution completed."
