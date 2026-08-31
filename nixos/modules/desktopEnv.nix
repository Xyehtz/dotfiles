{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  # File Manager
  programs.yazi.enable = true;
  
  programs.dank-material-shell = {
    # Enable DankMaterialShell
    enable = true;
    
    theme = "dark";

    # Specify which gop to use
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    # Systemd service
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    # Core fearures
    enableSystemMonitoring = true; # System monitoring tools
    enableDynamicTheming = true; # Wallpaper based themes
    enableAudioWavelength = true; # Audio visualizer

    # Disabled core features
    enableVPN = false;
    enableCalendarEvents = false;

    clipboardSettings = {
      maxHistory = 30;
      maxEntrySize = 5242880;
      autoClearDays = 1;
      clearAtStartup = true;
      disabled = false;
      disableHistory = false;
      disablePersist = true;
    };
  };

  # Other packcages
  home.packages = with pkgs; [
    rofi
  ];

  # Sync configs
  xdg.configFile."hypr/hyprland.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/hyprland/hyprland.lua";
    recursive = true;
  };
}
