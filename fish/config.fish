# Config file of Fish

# To make Fish the default shell on non NixOS distors use
# command -v fish | sudo tee -a /etc/shells
# chsh -s "$(command -v fish)"

# Environment variables used by the system
set -gx DBUS_SESSION_BUS_ADDRESS unix:path=/run/user/1000/bus
set -gx SSH_AUTH_SOCK /run/user/1000/ssh-agent.socket

# Start the SSH authentication for GitHub and GitLab
if not test -S $SSH_AUTH_SOCK
    ssh-agent -a $SSH_AUTH_SOCK >/dev/null
end

# Start hyprland after logging in
if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
    exec start-hyprland
end

# Remove the greeting message every time fish starts
set -g fish_greeting

# Start on home
cd ~

# Add Cargo bin to PATH
set -U fish_user_paths /home/alej-garz/.cargo/bin $fish_user_paths
