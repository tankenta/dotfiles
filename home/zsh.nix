{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      hms = "home-manager switch --flake ~/src/github.com/tankenta/dotfiles";
    };
    history = {
      size = 100000;
      save = 100000;
      share = true;
      ignoreAllDups = true;
    };
    initContent = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -Uz promptinit && promptinit
      prompt pure
    '';
  };
}
