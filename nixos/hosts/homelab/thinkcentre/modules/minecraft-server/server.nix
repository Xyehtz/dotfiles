{
  config,
  pkgs,
  lib,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/Xyehtz/dotfiles/85b7bffe768fedf108cbc2948f628882814ac42d/nixos/hosts/homelab/thinkcentre/modules/minecraft-server/pack.toml";
    packHash = "sha256-dR0s4QVxTvYPqECcucRi9Jr6xTtVXBD3Hp9mMoMrWy8=";
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
