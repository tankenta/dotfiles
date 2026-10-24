# dotfiles

Ubuntu 26.04 + Nix + home-manager (standalone, flake)。

## 反映

```sh
nix run home-manager -- switch --flake .          # 初回 (tanke@carina が自動で選ばれる)
home-manager switch --flake .                    # 2回目以降
```

初回のあと、Nix の GUI アプリ (Ghostty) が GPU を使えるように一度だけ実行する（switch の出力に表示されるパス）:

```sh
sudo /nix/store/<hash>-non-nixos-gpu/bin/non-nixos-gpu-setup
```

## 構成

| パス | 内容 |
|---|---|
| `home/` | home-manager モジュール (zsh + pure, git, Ghostty, Neovim, CLI ツール) |
| `config/nvim/` | Neovim 設定。`~/.config/nvim` から直接リンク |
| `etc/` | Nix 外 (apt / `/etc`) で手作業設定したものの控え |

## Nix 外で手作業した設定

- keyd: `etc/keyd/default.conf` を `/etc/keyd/default.conf` に置き、`sudo systemctl enable --now keyd`
- Mozc: キー設定で Muhenkan = IME 無効化、Henkan = IME 有効化（全モード）
- ログインシェル: `chsh -s /usr/bin/zsh`（zsh 本体は apt）

旧設定（大学時代〜2024）はタグ `legacy-univ` に残してある。
