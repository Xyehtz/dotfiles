{
  pkgs,
  lib,
  ...
}: {
  programs = {
    niri.enable = true;
    fish.enable = true;
    steam.enable = true;

    # CoreCtrl used for GPU undervolting
    corectrl = {
      enable = true;
      gpuOverclock.enable = true;
      gpuOverclock.ppfeaturemask = "0xffffffff";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Settings here are based on https://github.com/dreamsofcode-io/tmux/blob/main/tmux.conf
    tmux = {
      enable = true;

      extraConfigBeforePlugins = ''
        set -g @rose_pine_variant 'main'
      '';

      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.rose-pine
        tmuxPlugins.yank
      ];

      extraConfig = ''
        # True color
        set-option -sa terminal-overrides ",xterm*:Tc"
        set -g mouse on

        # Set Ctrl+Space as prefix
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        # Set Vim keys to change between windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Start indexing at 1
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Enable vi mode
        set-window-option -g mode-keys vi

        # Vi keybinds
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Rebind pane binds and open on current working directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # Styles
        set -g status-style "bg=#191724"
        setw -g window-status-format "#[fg=#31748f,bg=#191724]#[fg=#191724,bg=#31748f] #I #[fg=#31748f,bg=#191724]#[fg=#e0def4,bg=#191724] #W "
        setw -g window-status-current-format "#[fg=#f6c177,bg=#191724]#[fg=#191724,bg=#f6c177] #I #[fg=#f6c177,bg=#191724]#[fg=#e0def4,bg=#403d52] #W "
        setw -g window-status-separator " "
        set -g status-left ""
        set -g status-right "#[fg=#eb6f92,bg=#191724]#[fg=#191724,bg=#eb6f92] #{pane_current_command} #[fg=#eb6f92,bg=#191724]#[fg=#9ccfd8,bg=#191724]#[fg=#191724,bg=#9ccfd8] #{session_windows} #[fg=#9ccfd8,bg=#191724]"
      '';
    };
  };

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty

    # Terminal applications
    nvtopPackages.amd
    btop
    fastfetch
    ryzenadj
    yt-dlp
    corectrl

    # Browser
    librewolf

    # Matrix clients
    element-desktop

    # Notes
    obsidian

    # Email Client
    thunderbird

    # VPN, and File Sharing
    localsend

    # Other
    fuzzel
    xwayland-satellite
    nix-search-cli
    tailscale

    # SSH
    sshfs
    termius

    # API Tester
    bruno

    # School/College
    onlyoffice-desktopeditors
    teams-for-linux
    tigervnc
    swift
    sourcekit-lsp
    stirling-pdf-desktop
    jetbrains.idea
  ];

  # Allowed unfree software
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "obsidian"
      "rpcs3"
      "idea"
      "termius"
    ];
}
