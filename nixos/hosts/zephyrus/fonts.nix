{pkgs, ...}: {
  fonts.packages = with pkgs; [nerd-fonts.jetbrains-mono]; # Currently the preferred Terminal font
}
