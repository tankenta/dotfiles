{ pkgs, ... }:
let
  # Nix の btop は Ubuntu のライブラリを探さないので、ホストの NVIDIA 監視ライブラリ (apt のドライバ付属) だけを見せる。
  # ディレクトリごと LD_LIBRARY_PATH に入れるとホストの libc まで混ざるのでリンク1本だけにする
  hostNvml = pkgs.runCommand "host-nvml" { } ''
    mkdir -p $out/lib
    ln -s /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 $out/lib/
  '';
  btop = pkgs.symlinkJoin {
    name = "btop";
    paths = [ pkgs.btop ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/btop --prefix LD_LIBRARY_PATH : ${hostNvml}/lib";
  };
  catppuccin = pkgs.catppuccin.override { variant = "mocha"; };
in
{
  programs.btop = {
    enable = true;
    package = btop;
    themes.catppuccin_mocha = builtins.readFile "${catppuccin}/btop/catppuccin_mocha.theme";
    settings = {
      color_theme = "catppuccin_mocha";
      shown_boxes = "cpu mem net proc gpu0";
    };
  };

  programs.fastfetch.enable = true;
}
