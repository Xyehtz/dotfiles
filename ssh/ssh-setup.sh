# /bin/bash

# NOTE: 744 premissions need to be added with chmod

# This file has the main idea of simplyfing the process of setting up SSH Keys

# Because if the case of minimal installation like the one I have for NixOS
# certain folders like .ssh are not automatically created, set a way to create the dir
mkdir -p ~/.ssh

# Setup keys on ~/.ssh
ssh-keygen -t ed25519 -C "GitHub Key" -f ~/.ssh/GitHub
ssh-keygen -t ed25519 -C "GitLab key" -f ~/.ssh/GitLab

# Set up the keys after they have been created
eval "$(ssh-agent -s)" # Sart SSH agent

ssh-add ~/.ssh/GitHub
ssh-add ~/.ssh/GitLab

# Test the SSH Keys
ssh -T git@github.com
ssh -T git@gitlab.com
