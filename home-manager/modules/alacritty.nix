{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;

      window = {
        title = "Alacritty";
        dynamic_title = false;
      };

      font = {
        size = 13.0;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
      };

      colors.primary.background = "#1d2021";
    };
  };
}
