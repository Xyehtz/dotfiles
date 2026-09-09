{ config, lib, pkg, ... }:

{
  services.netbird.clients.wt0 = {
    login = {
      enable = true;
      setupKeyFile = "/etc/netbird/homelab-key";
    };

    autoStart = true;
    port = 51821;
    ui.enable = false;
    openFirewall = true;
    openInternalFirewall = true;
  };
}
