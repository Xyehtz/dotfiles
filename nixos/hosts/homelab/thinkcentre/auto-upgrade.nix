{...}: {
  system.autoUpgrade = {
    enable = true;
    dates = "Fri *-*-* 17:00";

    # NOTE: This also requires the dotfiles project to be pushed to GitHub in order to actually get the latest flake.lock
    flake = "github:Xyehtz/dotfiles?dir=nixos/hosts/homelab/thinkcentre#nixos";
    randomizedDelaySec = "15min";
  };
}
