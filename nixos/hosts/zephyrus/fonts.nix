{pkgs, ...}: {
  fonts.packages = with pkgs; [nerd-fonts.fira-code]; # Currently the preferred Terminal font
  fonts.fontconfig = {
    antialias = true;
    hinting = {
      enable = true;
      style = "slight";
    };
    subpixel.lcdfilter = "default";
  };
}
