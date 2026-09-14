{
  config,
  pkg,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
  };
}
