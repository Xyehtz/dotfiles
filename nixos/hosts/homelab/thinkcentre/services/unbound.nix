{
  config,
  lib,
  pkg,
  ...
}: {
  services.unbound = {
    enable = true;
    checkconf = true;
    enableRootTrustAnchor = true;

    settings = {
      server = {
        verbosity = "1";

        interface = ["127.0.0.1"];
        port = ["5335"];

        do-ip4 = "yes";
        do-ip6 = "yes";
        do-udp = "yes";
        do-tcp = "yes";

        harden-glue = "yes";
        harden-unverified-glue = "yes";

        prefetch = "yes";
      };
    };
  };
}
