{ config, pkgs, lib, ... }:

{
  services.pihole-ftl = {
    enable = true;
    settings = {
      dns.upstreams = [ "127.0.0.1#5335" ];
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "block";
        enabled = true;
        description = "Steven Black's block list";
      }
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "Hagezi's block list";
      }
      {
        url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/main/lists/nsfw.txt";
        type = "block";
        enabled = true;
        description = "NSWF domains from Zachlagden";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "440s" ]; # 443 is already in use by Matrix
  };

  networking.firewall.allowedTCPPorts = [ 53 440 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
