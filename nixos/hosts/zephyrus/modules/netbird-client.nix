{ config, pkg, lib, ... }:

{
  services.netbird.clients.wt0 = {
    port = 51821;
    openFirewall = true;
    openInternalFirewall = true;
  };
}
