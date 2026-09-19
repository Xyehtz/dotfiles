# This is to setup Synapse Admin with Caddy
{pkgs, ...}: let
  domain = "stryxredact.net";
in {
  services.nginx.virtualHosts."synapse-admin.stryxredact.net" = {
    enableACME = true;
    forceSSL = true;
    root = pkgs.ketesa.withConfig {
      restrictBaseUrl = ["https://matrix.${domain}"];
    };

    locations."/" = {
      extraConfig = ''
        allow 127.0.0.1;
        allow 192.168.68.0/22;
        deny all;
      '';
    };
  };
}
