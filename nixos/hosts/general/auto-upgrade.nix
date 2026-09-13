{...}: {
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/alej-garz/Projects/dotfiles/nixos/hosts/zephyrus#nixos";
    randomizedDelaySec = "15min";
  };
}
