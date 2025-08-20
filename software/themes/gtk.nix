{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 10;
    theme = {
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = ''1'';
    };
    gtk4.extraConfig = {
      gtk-theme-name = ''Nightfox:Dark'';
    };

  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
}
