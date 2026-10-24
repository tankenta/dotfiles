# ユーザーとマシンの前提

ユーザーは「たんけ」。日本語でやり取りする。趣味の個人開発者（PyTorch での DNN 開発経験あり、LLM 学習まわりは初心者レベルと自己申告）。

## やり取りの好み
- 日本語で、結論を先に、表や箇条書きで簡潔に
- 在庫や価格の話は「実際に買えるか」まで確認する
- 不確かなことは推測と明示する

## マシン（carina）
ローカルの大型 MoE LLM（Strata）と、3D CAD・動画/写真編集・ゲーム用に 2026年10月に自作した。LLM まわりの詳細は `~/src/github.com/tankenta/local-llm-lab/CLAUDE.md`。

| パーツ | 製品 | 備考 |
|---|---|---|
| CPU | AMD Ryzen 9 9950X3D（16C/32T、3D V-Cache は片側 CCD のみ） | Amazon 4年保証版 |
| マザボ | MSI MAG X870E TOMAHAWK WIFI（MS-7E59） | BIOS E7E59AMSI.2AC4（2026-09-02 ビルド、AGESA PI-1.3.0.1d） |
| メモリ | Lexar THOR RGB 2nd Gen DDR5-6000 CL40 64GB（32GB×2、LD5U32G60C40BV-RGD） | A2/B2。マザボの QVL に DDR5-6000 で掲載 |
| GPU | MSI GeForce RTX 5080 16GB（GB203、Blackwell、sm_120） | PCI_E1。RM1000x 付属の 12V-2x6 で直結 |
| SSD（メイン） | Acer Predator GM7000 2TB（NVMe Gen4、DRAM キャッシュ付き） | M2_1（CPU 直結） |
| SSD（サブ） | 手持ちの SATA SSD 1TB | 電源のみ接続、データ線は未接続。あとで NTFS に初期化して共有領域にする予定 |
| 電源 | Corsair RM1000x 2024（ATX 3.1） | |
| CPU クーラー | Thermalright Peerless Assassin 140 SE | |
| ケース | Corsair Obsidian 800D（前面 USB は 2.0 のみ） | |
| ネットワーク | 有線 Realtek RTL8126（5GbE）／ Wi-Fi 7 モジュール（チップ非公表、Linux 対応は不確実） | 有線前提。回線は au ひかり 10ギガを検討中 |

**現在のネット接続（一時的）:** 自宅の有線 LAN が使えないため、iPhone 16 Pro（povo 使い放題）の USB テザリング（ipheth）でしのいでいる。数十GB 級のダウンロードは、時間がかかる前提で進めるか有線の復旧を待つかを相談して決める。

### BIOS 設定（設定済み）
- EXPO Profile 1 有効 → DDR5-6000 で動作確認済み
- Initiate Graphic Adapter = IGD、Integrated Graphics = Force
  - モニター（1920x1080、拡大率 1.0）はマザボの HDMI（内蔵グラフィック）につなぎ、RTX 5080 の VRAM を LLM 用に空ける
  - ゲームのときは RTX 5080 の DP に直結した入力に切り替える想定
- PBO は Auto、X3D Gaming Mode は Disabled（LLM で16コアを使うため）
- Secure Boot 有効（Windows のゲームの不正防止のため）、fTPM 有効

### OS とディスク
- Ubuntu 26.04.1 LTS Desktop（amd64、GNOME / Wayland）、表示言語は日本語。カーネル 7.0 系
- NVMe（nvme0n1）: p1 = EFI（FAT32、1.13GB、/boot/efi）、p2 = ext4 1.00TB（`/`）、残り約1.05TB は Windows 11 用に未割り当て。ディスク暗号化なし
- NVIDIA ドライバ 595.99.02（CUDA 13.2 対応、apt / Canonical 署名済み）。アイドル時 P8・約22W、VRAM 使用は 15MiB 程度
- キーボード：HHKB（US 配列）。keyd で左右の ◇ を単押しで無変換／変換、Mozc で無変換＝IME 無効・変換＝IME 有効
- ターミナルでの貼り付けは Ctrl+Shift+V

### 残作業
- [ ] SATA SSD のデータ線をつなぎ、NTFS で初期化して Windows/Ubuntu 共有のデータ置き場にする
- [ ] 負荷中に `nvidia-smi -q | grep -A4 "GPU Link Info"` で PCIe Gen5 x16 を確認
- [ ] MemTest86 などでメモリの安定性確認（任意）
- [ ] 必要なら Wi-Fi を Intel AX210 に差し替え（BE200 は AMD 環境で動かない報告が多い）
- [ ] タイル型 WM の検討（後回し）
- [ ] Neovim 設定の作り直し（lazy.nvim 前提、後回し）

### 将来の Windows 11 同居（未実施）
- NVMe の未割り当て領域に入れ、既存の EFI パーティションを共用する
- 入れたあと: BIOS の起動順を GRUB（ubuntu）優先に戻す／`/etc/default/grub` に `GRUB_DISABLE_OS_PROBER=false` を追記して `sudo update-grub`／Windows の高速スタートアップ無効化／BitLocker に注意（共有ドライブは暗号化しない、回復キーは控える）／Ubuntu 側で `timedatectl set-local-rtc 1`
- 用途の分担：Ubuntu＝LLM / 開発、Windows＝ゲーム / 3D CAD など

## ディレクトリの方針
- ソースコード：`~/src/github.com/<owner>/<repo>`（ghq 形式、`ghq.root = ~/src`）
- 他人のリポジトリは clone したまま手を入れず、自分の設定やメモは `tankenta/` 下の自分のリポジトリに分ける
- ホーム直下や `~/Documents` にはコードを置かない
- 大きなモデルファイルは、ツールの既定の保存先に従う。自分で置く場合は `~/models/` にまとめる

## 環境の管理方針
- **Nix＋home-manager（standalone、flake）:** dotfiles は `~/src/github.com/tankenta/dotfiles`（private）。設定名は `tanke@carina`、反映は `hms`（= `home-manager switch --flake ~/src/github.com/tankenta/dotfiles`）
  - 管理しているもの：zsh（pure）、git、Ghostty（本体も Nix。GPU は `targets.genericLinux` の Mesa）、Neovim、herdr、lsd、bat、CLI ツール、フォント、この CLAUDE.md
  - ツールを試すだけなら `nix shell nixpkgs#<pkg>`。`nix profile install` は使わない
  - 将来 Mac も同じリポジトリで管理する可能性あり（nix-darwin＋home-manager）。その時点で共通部分とホスト固有部分を分ける
- **プロジェクトごとの開発環境:** 各リポジトリに `flake.nix` の `devShell`、direnv（nix-direnv）で自動切り替え
- **apt / `/etc` で管理するもの:** NVIDIA ドライバなど GPU・カーネル寄りのもの、zsh 本体（ログインシェル `/usr/bin/zsh`）、keyd、Mozc（ibus）。手作業の設定は dotfiles の `etc/` と README に控える
- **`~/.claude` は home-manager で管理しない**（Claude Code 自身が書き換えるため）。例外はこのファイル（`~/.claude/CLAUDE.md`）だけで、dotfiles の `config/claude/CLAUDE.md` へのリンク
- **GPU を使うプログラム（CUDA 系）は Nix でビルドしない。** NixOS ではない Ubuntu では、Nix で入れた GPU プログラムがホストの `libcuda` を見つけられないことが多い
