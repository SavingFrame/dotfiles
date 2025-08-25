{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    # font.name = "JetBrainsMono Nerd Font";
    # font.size = 10;
    theme = {
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
    };
    # Custom theme somehow slow down start of GTK4 applications
    iconTheme = {
      name = "Adwaita";
    };
    cursorTheme = {
      name = "BreezeX-RoséPine";
      package = pkgs.rose-pine-cursor;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = ''1'';
    };

  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RoséPine";
    size = 24;
  };
}
