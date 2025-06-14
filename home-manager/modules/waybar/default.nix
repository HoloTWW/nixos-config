{pkgs,...}:
{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "9 13 -10 18";

        modules-left = ["hyprland/workspaces" "hyprland/language" "keyboard-state" "hyprland/window" "hyprland/submap"];
        modules-center = ["clock" "custom/weather"];
        modules-right = ["pulseaudio" "custom/mem" "cpu" "backlight" "battery" "tray" "custom/theme"];

        "hyprland/workspaces" = {
          disable-scroll = true;
        };

    "hyprland/window" = {
        format = "{}";
        format-icons = {};
    };

    "hyprland/language" = {
        format-en = "US";
        format-ru = "RU";
	      min-length = 5;
	      tooltip = false;
    };

    "keyboard-state" = {
        #numlock = true;
        capslock = true;
        format = "{icon} ";
        format-icons = {
            locked = " ";
            unlocked = "";
        };
    };

    "clock" = {
        # timezone = "America/New_York";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "{:%a; %d %b, %I:%M %p}";
    };

    "custom/weather" = {
        format = "{}";
        tooltip = true;
        interval = 1800;
        exec = "$HOME/.config/waybar/scripts/wttr.py";
        return-type = "json";
    };

    "pulseaudio" = {
        # scroll-step = 1; # %, can be a float
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
        };
        on-click = "pavucontrol";
        min-length = 13;
    };

    "custom/mem" = {
        format = "{} ";
        interval = 3;
        exec = "free -h | awk '/Mem:/{printf $3}'";
        tooltip = false;
    };

    "custom/theme" = {
        format = "{}";
        exec = "${pkgs.bash}/bin/bash ${./scripts/toggle-theme.sh}";
        on-click = "${pkgs.bash}/bin/bash ${./scripts/toggle-theme.sh}";
        interval =  "once";
        signal = 1;
        tooltip = false;
    };

    "cpu" = {
      interval = 2;
      format = "{usage}% ";
      min-length = 6;
    };

    "temperature" = {
        # thermal-zone = 2;
        # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        critical-threshold = 80;
        # format-critical = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C {icon}";
        format-icons = ["" "" "" "" ""];
        tooltip = false;
    };

    "backlight" = {
        device = "intel_backlight";
        format = "{percent}% {icon}";
        format-icons = [""];
        min-length = 7;
    };

    battery = {
        states = {
            warning = 30;
            critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = ["" "" "" "" "" "" "" "" "" ""];
	on-update = "$HOME/.config/waybar/scripts/check_battery.sh";
    };

    tray = {
        icon-size = 16;
        spacing = 0;
    };

      };
    };
  };
}
