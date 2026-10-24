{ config, ... }:
{
  # ~/.claude 自体は Claude Code が書き換えるので管理しない。ユーザー全体の CLAUDE.md だけリンクする
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/github.com/tankenta/dotfiles/config/claude/CLAUDE.md";
}
