{...}: {
  services.atftpd = {
    enable = true;
    root = "/srv/tftp";
    extraOptions = [
      "--verbose=5"
    ];
  };

  networking.firewall.allowedUDPPorts = [69];
}
