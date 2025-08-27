{
  ...
}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    style = ''
            ${builtins.readFile (
              builtins.path {
                path = ./macchiato.css;
                name = "macchiato.css";
              }
            )}

            * {
                font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
                font-size: 20px;
            }

            window#waybar {
                background-color: rgba(0, 0, 0, 0);
                border-radius: 13px;
                transition-property: background-color;
                transition-duration: .5s;
            }

            button {
                /* Use box-shadow instead of border so the text isn't offset */
                box-shadow: inset 0 -3px transparent;
                /* Avoid rounded borders under each button name */
                border: none;
                border-radius: 0;
            }

            /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
            button:hover {
                background: inherit;
                box-shadow: inset 0 -3px #ffffff;
            }

            /* you can set a style on hover for any module like this */
            #pulseaudio:hover {
            background-color: @surface2;
            }

            #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: #ffffff;
            }


            #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
            }

            /*
            #workspaces button.active {
            background-color: @lavender;
            box-shadow: inset 0 -3px #ffffff;
            }
      			*/

            #workspaces button.urgent {
            background-color: #eb4d4b;
            }

            #mode {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
            }

            #clock,
            #battery,
            #language,
            #cpu,
            #memory,
            #temperature,
            #network,
            #pulseaudio {
            padding: 0 10px;
            }

            #pulseaudio {
            color: @maroon;
            }

            #network {
            color: @yellow;
            }

            #temperature {
            color: @sky;
            }

            #battery {
            color: @green;
            }

            #clock {
            color: @flamingo;
            }

            #window {
            color: @rosewater;
            }

            .modules-right,
            .modules-left,
            .modules-center {
                background-color: transparent;
                color: #ffffff;
                border-radius: 15px;
            }

            .modules-right {
                padding: 0 10px;
            }

            .modules-left {
                padding: 0 20px;
            }

            .modules-center {
                padding: 0 10px;
            }

            #battery.charging,
            #battery.plugged {
            color: @sapphire;
            }

            @keyframes blink {
                to {
                    color: #000000;
                }
            }

            /* Using steps() instead of linear as a timing function to limit cpu usage */
            #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
            }

            label:focus {
                background-color: #000000;
            }

            #pulseaudio.muted {
            color: @text;
            }
    '';
    settings = [
      {
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        height = 30;
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "hyprland/language"
          "tray"
          "pulseaudio"
          "network"
          "memory"
          "cpu"
          "temperature"
          "clock"
        ];
        "hyprland/window" = {
          format = { };
          max-length = 35;
          rewrite = {
            "" = "Harsh";
          };
          separate-outputs = true;
        };
        "hyprland/language " = {
          format = { };
          format-en = "Eng";
          format-uk = "Ukr";
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "active" = " ";
          };
          "sort-by-number" = true;
          "persistent-workspaces" = {
            "*" = 4;
          };
        };
        "clock" = {
          "format" = "{:%d.%m.%Y %H:%M:%S}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
          "interval" = 1;
        };
        "cpu" = {
          "format" = "  {usage}%";
          "tooltip" = true;
        };
        "memory" = {
          "format" = " {used:.1f} GB";
        };
        "temperature" = {
          "thermal-zone" = 1;
          "critical-threshold" = 80;
          "format" = "{icon} {temperatureC}°C";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon}  {capacity}%";
          "format-full" = "{icon}  {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "network" = {
          "format-wifi" = "  {signalStrength}%";
          "format-ethernet" = "{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = " ⚠ ";
          "format-alt" = "{ifname}= {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{icon}  {volume}%";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
        "tray" = {
          "spacing" = 10;
          "icon-size" = 21;
        };
      }
    ];
  };
}
