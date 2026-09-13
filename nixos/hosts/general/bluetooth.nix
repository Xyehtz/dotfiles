{...}: {
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show the battery of connected devices
        FastConnectable = false; # The power consumptions trade-off is not worth it
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };
}
