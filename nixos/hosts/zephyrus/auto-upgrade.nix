{...}: {
  # NOTE: As of 13/09/2026 there is an issue with the latest Kernel (7.2.5) where loading the amdgpu Kernel module results in an error. The update frequency has been decreased because of this.
  system.autoUpgrade = {
    enable = true;
    dates = "Fri *-*-01..07 16:30";

    # NOTE: This also requires the dotfiles project to be pushed to GitHub in order to actually get the latest flake.lock
    flake = "github:Xyehtz/dotfiles?dir=nixos/hosts/zephyrus#nixos";
    randomizedDelaySec = "15min";
  };
}
