{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./ghostty.nix
    ./nvim.nix
  ];

  home.username = "tanke";
  home.homeDirectory = "/home/tanke";
  home.stateVersion = "26.05";

  # Ubuntu (non-NixOS) 向け: XDG_DATA_DIRS 等の調整と GPU ドライバ (Mesa) のリンク
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  # Claude Code (ネイティブインストーラ) などが入る場所。bash では ~/.profile が足していた
  home.sessionPath = [ "$HOME/.local/bin" ];

  home.packages = with pkgs; [
    herdr
    ghq
    gh
    ripgrep
    fd
    jq
  ];

  programs.fzf.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
