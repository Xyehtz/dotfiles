{
  config,
  pkgs,
  lib,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/Xyehtz/dotfiles/1a80910190d76e02fe7b488954ec64767c15cf08/nixos/hosts/homelab/thinkcentre/modules/minecraft-server/pack.toml";
    packHash = "sha256-BVuXVfChdWTDitQxgLegsDuWqsEWPi7SdURRWIzNaf4=";
    side = "server";
  };
in {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.main = {
      enable = true;
      package = pkgs.neoforgeServers.neoforge-1_21_1.override {
        # From what I've seen when doing the Minecraft servers
        # it usually ends up better to specify the JRE version as
        # an override because sometimes nix-minecraft may end up
        # using the incorrect version of Java
        jre_headless = pkgs.jdk21_headless;
      };

      whitelist = {
        Xyehtz = "c34aa321-e932-461b-b8c1-d2f34f96aee5";
        Aureliano_12 = "607b1dd8-c3cf-459b-8ca5-8ae02154cf41";
        raccoonwash3195 = "76cb206d-b05f-4feb-a620-1c9e5b1b76ea";
        OddlySour = "1afabcdd-7455-40c8-acfc-05e6f4f6f34c";
        konglong_1h1jYh = "725af824-4eeb-402b-8059-bb6c9aab0ae6";
      };

      serverProperties = {
        server-port = 25565;
        online-mode = true;
      };

      symlinks = {
        mods = "${modpack}/mods";
      };

      jvmOpts = "-Xms6G -Xmx6G";
    };
  };

  # Allow the Minecraft server
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "minecraft-server"
      "neoforge"
    ];
}
