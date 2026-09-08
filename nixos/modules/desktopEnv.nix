{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # File Manager
  programs.yazi.enable = true;

  # Other packcages
  home.packages = with pkgs; [
    upower # Noctalia uses UPower for battery status
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
        default.path = "/home/alej-garz/Wallpapers/Rei.png";
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
        pre_action_fade_seconds = 2.5;

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

      notifications = {
        enable_daemon = true;
        show_app_name = true;
        show_actions = false;
        position = "bottom_left";
        layer = "top";
        scale = 1.0;
        background_opacity = 0.9;
        offset_x = 20;
        offset_y = 8;
        monitors = [];
        collapse_on_dismiss = true;
        keep_dismissed_in_history = false;
        max_visible = 0;
        history_retention_hours = 3;
      };

      weather = {
        enabled = true;
        refresh_minutes = 60;
        unit = "metric";
        effects = true;
      };

      bar = {
        order = "main";

        default = {

          # Position and hide settings
          position = "top";
          enabled = true;
          auto_hide = false; 
          smart_auto_hide = false;
          layer = "top";

          # Bar style settings
          thickness = 34;
          background_opacity = 0.9;
          border = "outline";
          shadow = true;
          contact_shadow = true;
          radius_top_left = 0;
          radius_top_right = 0;
          radius_bottom_left = 12;
          radius_bottom_right = 12;
          margin_ends = 0;
          margin_edge = 0;
          padding = 14;
          widget_spacing = 6;
          hover_highlight = true;
          scale = 1.0;
          font_scale = 1.0;
          font_weight = 500;

          # Capsule settings (for widget groups)
          capsule = true;
          capsule_fill = "surface_variant";
          capsule_thickness = 0.75;
          capsule_opacity = 1.0;
        
          # Widgets
          start = [ "cpu" "temp" "ram" "audio_visualizer" ];
          center = [ "workspaces" ];
          end = [ "notifications" "network" "bluetooth" "volume" "clock" "control-center" "session" ];
        };
      };

      widget = {

        # Start - Sysmon
        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
        };

        temp = {
          type = "sysmon";
          stat = "cpu_temp";
        };

        ram = {
          type = "sysmon";
          stat = "ram_used";
        };

        # Start - Audio visualizer
        audio-vis = {
          type = "audio_visualizer";
          width = 128;
          mirrored = false;
          bands = 40;
          show_when_idle = false;
        };

        # Center - Workspaces
        workspaces = {
          style = "regular";
          show_labels = true;
          show_icons = false;
          labels_only_when_occupied = true;
          hide_when_empty = true;
          pill_scale = 1.0;
          active_pill_size = 2.2;
          inactive_pill_size = 1.0;
        };

        # End - Network
        network = {
          show_label = false;
          vpn_status = "replace";
        };

        # End - Volume
        volume = {
          device = "output";
          mute_color = "error";
        };

        # End - Clock
        clock = {
          format = "{:%-I:%M %p} • {:%a, %b %d}";
        };
      };
    };
  };

  # Sync configs
  xdg.configFile."niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/niri/config.kdl";
    recursive = true;
  };
}
