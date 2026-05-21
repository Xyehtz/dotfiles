# Config file of Fish

# Environment variables used by the system
set -gx DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
set -gx SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Start the SSH authentication for GitHub and GitLab
if not pgrep -u "$USER" ssh-agent >/dev/null
    ssh-agent -a "$SSH_AUTH_SOCK" -D >/dev/null 2>&1 &
end

# Start hyprland after logging in
if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
    exec start-hyprland
end

# Remove the greeting message every time fish starts
set --erase fish_greeting
