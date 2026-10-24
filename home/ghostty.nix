{ pkgs, ... }:
{
  home.packages = [ pkgs.hackgen-nf-font ];
  fonts.fontconfig.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "HackGen Console NF";
      font-size = 12;
      theme = "Catppuccin Mocha";
    };
  };
}
