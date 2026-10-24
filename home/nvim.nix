{ config, pkgs, ... }:
{
  home.packages = [ pkgs.neovim ];
  home.sessionVariables.EDITOR = "nvim";

  # 設定はリポジトリ内を直接リンクし、switch せずに編集を反映できるようにする
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/github.com/tankenta/dotfiles/config/nvim";
}
