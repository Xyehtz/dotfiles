{
  # Diagnostics and other useful information
  diagnostics.inline.enabled = true;
  code_lenss = "on";

  # Zed motion type
  helix_mode = true;

  # Sections organization
  project_panel.dock = "left";
  outline_panel.dock = "left";
  collaboration_panel.dock = "left";
  git_panel.dock = "left";
  terminal.dock = "right";

  # Themes (Editor and Icons)
  theme = {
    mode = "dark";
    light = "Ayu Light";
    dark = "Carbonfox - opaque";
  };
  icon_theme = "Base Charmed Icons";
  ui_font_size = 16;
  buffer_font_size = 15;
  buffer_font_family = "Iosevka Nerd Font Mono";

  # Save settings
  format_on_save = "off";
  autosave.after_delay.milliseconds = 500;

  # Disable Telemetry
  telemetry = {
    diagnostics = false;
    metrics = false;
  };

  # AI Settings for Code Completion
  edit_predictions = {
    mode = "subtle";
    ollama = {
      api_url = "http://<TAILSCALE_IP>:11434";
      model = "<MODEL>";
    };
    provider = "ollama";
  };

  # Settings required by extensions
  # Required by the Blade Extension
  file_types = {
    Blade = [ "*.blade.php" ];
  };

  # Required by the PHPCS Extension
  languages = {
    PHP = {
      language_servers = [
        "phpcs"
        "!phpactor"
      ];
    };
  };
}
