{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./ghostty.nix
    ./nvim.nix
    ./claude.nix
    ./btop.nix
  ];

  home.username = "tanke";
  home.homeDirectory = "/home/tanke";
  home.stateVersion = "26.05";

  # Ubuntu (non-NixOS) 向け: XDG_DATA_DIRS 等の調整と GPU ドライバ (Mesa) のリンク
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
  news.display = "silent"; # switch のたびの「未読のお知らせ」表示を消す。読むときは home-manager news

  # Claude Code (ネイティブインストーラ) などが入る場所。bash では ~/.profile が足していた
  home.sessionPath = [ "$HOME/.local/bin" ];

  home.packages = with pkgs; [
    herdr
    ghq
    gh
    ripgrep
    fd
    jq
    uv
  ];

  programs.fzf.enable = true;
  programs.lsd = {
    enable = true; # ls, ll, la, lt などのエイリアスも入る
  };
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Mocha";
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
