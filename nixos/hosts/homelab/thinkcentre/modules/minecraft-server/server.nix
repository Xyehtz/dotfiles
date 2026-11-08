{
  config,
  pkgs,
  lib,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/Xyehtz/dotfiles/e4590edaafded4314d13b49e90d68acd534bd272/nixos/hosts/homelab/thinkcentre/modules/minecraft-server/pack.toml";
    packHash = "sha256-8Nmk93SdLp7WEkgrctVTpP2bGvU//bOLIkMKP6PrnBE=";
  };
in {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.main = {
      enable = true;
      package = pkgs.fabricServers.fabric-26_3.override {
        jre_headless = pkgs.jdk25_headless;
      };

      serverProperties = {
        server-port = 25565;
        online-mode = true;
      };

      symlinks = {
        mods = "${modpack}/mods";
      };

      jvmOpts = "-Xms2G -Xmx2G";
    };
  };

  # Allow the Minecraft server
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "minecraft-server"
    ];
}
