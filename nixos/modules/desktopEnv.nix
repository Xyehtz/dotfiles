{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # File Manager
  programs.yazi.enable = true;

  # Other packcages
  home.packages = with pkgs; [

  ];

  programs.noctalia = {
    enable = true;

    settings = {

      # The whole theme of this rice is to follow the Wallpaper
      theme = {
        mode = "dark";
        shell_mode = "follow";
        source = "wallpaper"; # Follow the colors of the wallpaper
        wallpaper_scheme = "m3-content";
        pure_black_dark = true;
      };

      wallpaper = {
        # transition is omitted to have the effects picked at random
        enabled = true;
        fill_mode = "crop";
        transition_duration = 1500;
        edge_smoothness = 0.4;
        directory = "/home/alej-garz/Wallpapers";

        # Automated wallpaper change
        automation = {
          enabled = true;
          interval_seconds = 1800; # Change every 30 mins 
          order = "random";
          recursive = true;
        };

        # Default wallpaper
        default.path = "/home/alej-garz/Wallpapers/Nier-Blade.png";
      };

      audio = {
        enable_overdrive = true;
        enable_sounds = true; # Not really sure what this one does
      };

      battery.warning_threshold = 15;

      # Configuration to show holidays in Canada
      calendar = {
        enabled = true;
        refresh_minutes = 30;
        event_date_format = "%A %e %B";
        event_time_format = "%H:%M";

        # Calendar source
        account.holidays = {
          name = "Canadian Holidays";
          server_url = "https://canada-holidays.ca/ics?cd=true";
          type = "ics";
          color = "#FF0000";
        };
      };

      idle = {
        behavior_order = [ "lock" "screen-off" ];
        pre_action_fade_seconds = 5.0;

        behavior = {
          lock = {
            timeout = 300; # 5 mins before lock
            action = "lock";
            enabled = true;
          };

          screen-off = {
            timeout = 60; # 1 min to screen off after lock
            action = "screen_off";
            enabled = true;
          };

          suspend = {
            enabled = false;
          };
        };
      };

      location = {
        auto_locate = false;
        address = "Toronto, ON";
      };

      nightlight = {
        enabled = true;
        temperature_day = 6000;
        temperature_night = 5000;
      };
    };
  };

  # Sync configs
  xdg.configFile."niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/niri/config.kdl";
    recursive = true;
  };

  # xdg.configFile."quickshell/noctalia/settings.json" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/noctalia/settings.json";
  # };
}
