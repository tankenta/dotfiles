" Charset, Line ending
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" backspace でなんでも消せるようにする
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]	" 行頭から前行文末へ移動可能にする

"set list          " 不可視文字の可視化
" デフォルト不可視文字の代わりに綺麗な Unicode 文字を利用
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:% ",eol:↲
set cursorline    " カーソルラインハイライト
set t_ut=         " WSLでの背景色
set number        " 行番号の表示
set wrap          " 長いテキストの折り返し
set textwidth=0   " 自動的に改行が入るのを無効化
set colorcolumn=80 " その代わり80文字目にラインを入れる
" スクリーンの無効化
set t_vb=
set novisualbell
set guioptions-=m				" メニューバーを非表示
set guioptions-=T				" ツールバーを非表示

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround    " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set scrolloff=3					" スクロールを開始する行数
set cindent						" cオートインデント
set cinoptions=g0				" cppでのpublic宣言を下げる

set ignorecase    " 大文字小文字を区別しない
set smartcase     " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch     " インクリメンタルサーチ
set hlsearch      " 検索マッチテキストをハイライト
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

set infercase     " 補完時に大文字小文字を区別しない
set virtualedit=all    "カーソルを文字が存在しない部分でも動けるようにする
set hidden        " バッファを閉じる代わりに隠す（Undo 履歴を残すため）
set switchbuf=useopen  " 新しく開く代わりに既に開いてあるバッファを開く
set showmatch     " 対応する括弧などをハイライト表示する
set matchtime=3   " 対応括弧のハイライト表示を3秒にする
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックアップファイル無効化
set nowritebackup
set nobackup
" set noswapfile

" マウスとクリップボード
set mouse=v
" set clipboard=autoselect

" <Leader> のマッピング
let mapleader = ","

" クリップボードをデフォルトのレジスタとして指定．
" YankRing 向けに 'unnamedplus' が存在しているかどうかで設定を分ける
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif

" === Folding ===
autocmd FileType * set foldmethod=syntax
autocmd FileType python set foldmethod=indent
autocmd FileType cpp set foldmethod=indent
autocmd FileType glsl set foldmethod=indent
autocmd FileType verilog set foldmethod=indent
autocmd FileType text set foldmethod=indent
" set nofoldenable "自動では折りたたまない
set foldlevel=0
set foldcolumn=2

" === PreviewWindow ===
set completeopt=menuone,longest,preview	" プレビューウインドウで表示
" set completeopt=menuone
set previewheight=1						" プレビューウインドウの高さ
set splitbelow							" 下に表示
set laststatus=2						" ステータスラインを常に表示

" === Tab Settings ===
" Hard Tab
" autocmd FileType * set tabstop=4 | set shiftwidth=4 | set noexpandtab
" Soft Tab
autocmd FileType javascript set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType typescript set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType html		set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType ruby 		set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd Filetype cpp 		set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType python     set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType tex     	set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType matlab     set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType fortran    set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType sql    	set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType yaml    	set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType neosnippet set noexpandtab "効いていない？

"===============================
" マクロおよびキー設定
"===============================
" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

" 再描画
nnoremap <F5> <C-l>
inoremap <F5> <Esc><C-l>a

" 挿入モード中に素早く jj と入力した場合は ESC とみなす
inoremap jj <Esc>

" ESC を二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を '*' で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に行う
nnoremap j gj
nnoremap k gk
noremap <Up> g<Up>
noremap <Down> g<Down>

" 高速移動 上下移動は滑らかに
noremap <C-h> 10h
noremap <C-l> 10l
noremap <C-j> 2j2j2j2j2j
noremap <C-k> 2k2k2k2k2k

" 行末行頭への移動
noremap 9 ^
noremap 0 $

" v を二回で行末まで選択
vnoremap v $h

" TAB で対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" PreviewWindowの非表示
nnoremap <C-c> <C-w>z
inoremap <C-c> <C-w>z

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的に QuickFix を開く
autocmd MyAutoCmd QuickFixCmdPost make,grep,grepadd,vimgrep copen

" QuickFix および Help では q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudo が使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際フォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" omni補完
inoremap <C-o> <C-x><C-o>
" Escで補完ポップアップを閉じて標準モード
inoremap <expr><Esc> pumvisible() ? neocomplete#close_popup()."<Esc>" : "<Esc>"
