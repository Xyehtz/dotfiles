{...}: {
  # Set the governor for the laptop when in battery and charger
  services = {
    asusd = {enable = true;};
    cardwired = {
      enable = true;
      settings = {
        auto_apply_gpu_state = true;
        battery_auto_switch = true;
        battery_auto_switch_mode = "smart";
        external_display_auto_switch = true;
      };
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      pulse = {enable = true;};
    };

    # The power profiles daemon needs to be removed/disabled because otherwise
    # the auto-cpufreq service won't work because it will conflict with the power profiles
    power-profiles-daemon = {enable = false;};

    pulseaudio = {enable = false;};

    xserver = {videoDrivers = ["amdgpu"];};
  };
}
