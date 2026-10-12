{...}: let
  caremondaServer = "funny.stryxredact.net";
in {
  services.nginx.virtualHosts.${caremondaServer} = {
    enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.238.1:26474";
      extraConfig = ''
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [26474];
}
