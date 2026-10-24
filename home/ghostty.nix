{ pkgs, ... }:
{
  home.packages = [ pkgs.udev-gothic-nf ];
  fonts.fontconfig.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "UDEV Gothic NF";
      font-size = 12;
      theme = "Catppuccin Mocha";
    };
  };
}
