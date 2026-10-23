{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 12;
          y = 12;
        };
        dynamic_padding = true;
        opacity = 0.88;
        blur = true;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        size = 11.5;
      };

      keyboard.bindings = [
        {
          key = "Return";
          mods = "Shift";
          chars = "\r";
        }
      ];

      colors = {
        primary = {
          background = "#121318";
          foreground = "#e2e2e9";
        };
        normal = {
          black = "#1a1b20";
          red = "#ffb4ab";
          green = "#b5cc92";
          yellow = "#e5c18d";
          blue = "#afc6ff";
          magenta = "#d9bde2";
          cyan = "#8ad4d6";
          white = "#e2e2e9";
        };
        bright = {
          black = "#44464f";
          red = "#ff897d";
          green = "#cce8a3";
          yellow = "#ffdca7";
          blue = "#d7e2ff";
          magenta = "#f6d8ff";
          cyan = "#a5f0f2";
          white = "#ffffff";
        };
      };
    };
  };

  # Also install Kitty as fallback
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.85";
      font_family = "JetBrainsMono Nerd Font";
      font_size = "11.5";
      confirm_os_window_close = 0;
    };
  };
}
