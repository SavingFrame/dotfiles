{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      # Note: The 'source' directive needs to be handled separately in Nix
      # You may need to import the contents of ~/.config/hypr/configs/configs.conf
      # or convert those settings to Nix as well

      background = [
        {
          monitor = "";
          path = "$HOME/Pictures/Wallpapers/black_waves_4k_hd_black.jpg";
          blur_passes = 2;
          contrast = 1;
          brightness = 0.9;
          vibrancy = 1;
          vibrancy_darkness = 0.0;
        }
      ];

      general = {
        no_fade_in = false;
        no_fade_out = false;
        grace = 0;
        disable_loading_bar = false;
      };

      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 3;
          dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
          outer_color = "rgba(9eaabcFF)";
          inner_color = "rgba(9eaabcFF)";
          font_color = "rgba(3F6187FF)";
          fade_on_empty = false;
          fade_timeout = 2000; # Milliseconds before fade_on_empty is triggered.
          placeholder_text = ''<i> <span foreground="#000000"> Enter Password...</span> </i>'';
          hide_input = false;
          rounding = -1; # -1 means complete rounding (circle/oval)
          check_color = "rgba(d3d4e6FF)";
          fail_color = "rgba(255, 0, 0, 1)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
          fail_transition = 300;
          capslock_color = "rgba(d3d4e6FF)";
          numlock_color = "rgba(d3d4e6FF)";
          bothlock_color = "rgba(d3d4e6FF)";
          invert_numlock = false;
          swap_font_color = "rgba(9eaabcFF)";
          position = "0, 100";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # time (hour)
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%H')\"";
          color = "rgba(9eaabcFF)";
          font_size = 200;
          font_family = "Montserrat Italic Bold";
          position = "-50, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }

        # time (minute)
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%M')\"";
          color = "rgba(9eaabcFF)";
          font_size = 200;
          font_family = "Montserrat Italic Bold";
          position = "50, -10";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }

        # time (seconds)
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%S')\"";
          color = "rgba(9eaabcFF)";
          font_size = 100;
          font_family = "Montserrat Italic Bold";
          position = "330, -60";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }

        # date
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +'%d %B, %Y')\"";
          color = "rgba(9eaabcFF)";
          font_size = 25;
          font_family = "Pacifico Regular";
          position = "0, -150";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }

        # Commented out sections from your original config:

        # time (seconds) - uncomment and add to label list if needed

        # user label - uncomment and add to label list if needed
        # {
        #   monitor = "";
        #   text = "$USER";
        #   color = "rgba(9eaabcFF)";
        #   font_size = 40;
        #   font_family = "Fira Bold";
        #   position = "-50, 120";
        #   halign = "right";
        #   valign = "bottom";
        #   shadow_passes = 5;
        #   shadow_size = 10;
        # }

        # uptime label - uncomment and add to label list if needed
        # {
        #   monitor = "";
        #   text = "cmd[update:60000] echo \"<b> $(uptime -p) </b>\"";
        #   color = "rgba(9eaabcFF)";
        #   font_size = 18;
        #   font_family = "Fira Bold";
        #   position = "0, 0";
        #   halign = "left";
        #   valign = "bottom";
        # }

        # image section - uncomment if needed
        # image = [
        #   {
        #     monitor = "";
        #     path = "$HOME/.config/hypr/.cache/user.png";
        #     size = 280; # lesser side if not 1:1 ratio
        #     rounding = -1; # negative values mean circle
        #     border_size = 8;
        #     border_color = "rgba(9eaabcFF)";
        #     rotate = 0; # degrees, counter-clockwise
        #     reload_time = -1; # seconds between reloading, 0 to reload with SIGUSR2
        #     position = "-45, 190";
        #     halign = "right";
        #     valign = "bottom";
        #   }
        # ];
      ];
    };
  };
}
