{pkgs, ...}: {
  # Gaming clients, and other gaming related applications
  home.packages = with pkgs; [
    gamescope
    mangohud

    # Clients
    steam
    heroic

    # Mod Clients
    deadlock-mod-manager

    # Emulators
    rpcs3
  ];
}
