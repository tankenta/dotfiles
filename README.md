# dotfiles

Ubuntu 26.04 + Nix + home-manager (standalone, flake)。

## 反映

```sh
nix run home-manager -- switch --flake .          # 初回 (tanke@carina が自動で選ばれる)
home-manager switch --flake .                    # 2回目以降
hms                                              # 同上 (どこからでも。zsh のエイリアス)
```

初回のあと、Nix の GUI アプリ (Ghostty) が GPU を使えるように一度だけ実行する（switch の出力に表示されるパス）:

```sh
sudo /nix/store/<hash>-non-nixos-gpu/bin/non-nixos-gpu-setup
```

## 構成

| パス | 内容 |
|---|---|
| `home/` | home-manager モジュール (zsh + pure, git, Ghostty, Neovim, btop, CLI ツール) |
| `config/nvim/` | Neovim 設定。`~/.config/nvim` から直接リンク |
| `config/claude/CLAUDE.md` | Claude Code のユーザー全体用 CLAUDE.md。`~/.claude/CLAUDE.md` から直接リンク |
| `etc/` | Nix 外 (apt / `/etc`) で手作業設定したものの控え |

## Nix 外で手作業した設定

- keyd: `etc/keyd/default.conf` を `/etc/keyd/default.conf` に置き、`sudo systemctl enable --now keyd`
- Mozc: キー設定で Muhenkan = IME 無効化、Henkan = IME 有効化（全モード）
- ログインシェル: `chsh -s /usr/bin/zsh`（zsh 本体は apt）
- herdr の Claude Code 連携: `herdr integration install claude`（`~/.claude/hooks/herdr-agent-state.sh` と `~/.claude/settings.json` の SessionStart hook。herdr サーバー再起動後のセッション復帰用）。`~/.claude` は Claude Code 自身が書き換えるので home-manager では管理しない

旧設定（大学時代〜2024）はタグ `legacy-univ` に残してある。
