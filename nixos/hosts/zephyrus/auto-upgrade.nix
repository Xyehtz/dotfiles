{
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/alej-garz/Projects/dotfiles/nixos#nixos";
    randomizedDelaySec = "15min";
  };
}