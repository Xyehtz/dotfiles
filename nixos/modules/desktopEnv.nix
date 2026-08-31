{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];
  
  programs.dank-material-shell = {
    # Enable DankMaterialShell
    enable = true;

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
  };

  # Other packcages
  home.packages = with pkgs; [
    rofi
  ];
}
