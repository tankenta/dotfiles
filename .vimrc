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
set clipboard=autoselect

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
autocmd FileType * set tabstop=4 | set shiftwidth=4 | set noexpandtab
" Soft Tab
autocmd FileType javascript set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType html		set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd FileType ruby 		set tabstop=2 | set shiftwidth=2 | set expandtab
autocmd Filetype cpp 		set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType python     set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType tex     	set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType matlab     set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType fortran    set tabstop=4 | set shiftwidth=4 | set expandtab
autocmd FileType sql    	set tabstop=4 | set shiftwidth=4 | set expandtab
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


"===============================
" NeoBundle
"===============================
filetype plugin indent off

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

NeoBundleLazy "Shougo/unite.vim", {
      \ "autoload": {
      \   "commands": ["Unite", "UniteWithBufferDir"]
      \ }}
NeoBundleLazy 'Shougo/unite-outline', {
      \ "autoload": {
      \   "unite_sources": ["outline"],
      \ }}
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>
let s:hooks = neobundle#get_hooks("unite.vim")
function! s:hooks.on_source(bundle)
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    " use vimfiler to open directory
    call unite#custom_default_action("source/bookmark/directory", "vimfiler")
    call unite#custom_default_action("directory", "vimfiler")
    call unite#custom_default_action("directory_mru", "vimfiler")
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        imap <buffer> <Esc><Esc> <Plug>(unite_exit)
        nmap <buffer> <Esc> <Plug>(unite_exit)
        nmap <buffer> <C-n> <Plug>(unite_select_next_line)
        nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
    endfunction
endfunction


NeoBundleLazy 'Shougo/vimfiler', {
            \ 'depends': ['Shougo/unite.vim'],
            \ 'autoload': {
            \   'commands': ['VimFilerTab', 'VimFiler', 'VimFilerExplorer'],
            \   'mappings': ['<Plug>(vimfiler_switch)'],
            \   'explorer': 1,
            \ }}
nnoremap <Leader>e :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks('vimfiler')
function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1

    " . から始まるファイル及び .pyc で終わるファイルを不可視パターンに
    let g:vimfiler_ignore_pattern = '\%(^\..*\|\.pyc$\)'

    " vimfiler specific key mappings
    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
        " ^^ to go up
        nmap <buffer> ^^ <Plug>(vimfiler_swich_to_parent_directory)
        " use R to refresh
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        " overwrite C-l
        nmap <buffer> <C-l> <C-w>l
    endfunction
endfunction


NeoBundle "thinca/vim-template"
" テンプレート中に含まれる特定文字列を置き換える
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd MyAutoCmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif


NeoBundleLazy "Shougo/neocomplete.vim", {
            \ "autoload": {
            \ "insert": 1,
            \ }}
let g:neocomplete#enable_at_startup = 1
" don't skip completion if it takes much time
let g:neocomplete#skip_auto_completion_time = ""
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_smart_case = 1
endfunction


NeoBundle "Shougo/neosnippet.vim"
" Plugin key-mappings
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior
imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
" For snippet_complete marker
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" my snippet
let s:my_snippet = '~/.vim/snippet/'
let g:neosnippet#snippets_directory = s:my_snippet

NeoBundle "Shougo/neosnippet-snippets"

NeoBundle "thinca/vim-quickrun"
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config.processing = {
			\	'command': 'processing-java',
			\	'exec': '%c --sketch=$PWD/ --output=/$PWD/output --force --run',
			\	}

NeoBundle 'tyru/caw.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'itchyny/lightline.vim'		    " ステータスライン
NeoBundle 'nathanaelkane/vim-indent-guides' " インデント明示化

NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'

"=== GLSL ===
NeoBundle 'tikhomirov/vim-glsl'

"=== C/C++ ===
NeoBundleLazy 'vim-jp/cpp-vim', {
			\ 'autoload':{ 'filetypes':[ 'cpp' ]} }
" NeoBundleLazy 'Rip-Rip/clang_complete', {
" 			\ 'autoload':{ 'filetypes':[ 'c', 'cpp' ]} }
NeoBundleLazy 'osyo-manga/vim-marching', {
			\ 'autoload':{ 'filetypes':[ 'c', 'cpp' ]},
			\ 'depends' : ['Shougo/vimproc'] }

"=== Python ===
" NeoBundleLazy 'davidhalter/jedi-vim', {
" 			\ 'autoload':{ 'filetypes':[ 'python' ]} } "sudo pip install jedi pep8 pyflakes

"=== JavaScript ===
NeoBundleLazy 'marijnh/tern_for_vim', {
			\ 'autoload':{ 'filetypes':[ 'javascript' ]},
			\ 'build': { 'others': 'npm install' } }
NeoBundleLazy 'pangloss/vim-javascript', {
		 	\ 'autoload':{ 'filetypes':[ 'javascript' ]} }
NeoBundleLazy 'othree/yajs', {
		 	\ 'autoload':{ 'filetypes':[ 'javascript' ]} }
NeoBundleLazy 'maxmellon/vim-jsx-pretty', {
		 	\ 'autoload':{ 'filetypes':[ 'javascript' ]} }
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
		 	\ 'autoload':{ 'filetypes':[ 'javascript' ]} }

"=== Processing ===
NeoBundleLazy 'sophacles/vim-processing', {
			\ 'autoload':{ 'filetypes':[ 'processing' ]} }

"=== Arduino ===
NeoBundle 'sudar/vim-arduino-syntax'

"=== PlantUML ===
NeoBundle 'aklt/plantuml-syntax'

"=== TeX ===
let g:tex_conceal = ''

"=== Fortran ===
let g:fortan_free_source = 1
let g:fortran_fold = 1
let g:fortran_fold_conditionals = 1
let g:fortran_do_enddo = 1

NeoBundleCheck
call neobundle#end()

filetype plugin indent on


set t_Co=256
syntax on
colorscheme jellybeans


"####### Plugin : vim-indent-guides #######
let g:indent_guides_enable_on_vim_startup = 1 "autostart

"####### Plugin : lightline #######
"ステータスライン 
"       \              [ 'fileencoding', 'filetype' ] ],
let g:lightline = {
	  \ 'colorscheme': 'Tomorrow_Night_Bright',
      \ 'active': {
	  \   'left': [ ['mode', 'paste'],
	  \     ['readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype', 'syntastic'] ]
      \ },
	  \ 'component': {
	  \   'readonly': '%{&readonly?"R":"W"}',
	  \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
	  \ 'separator': {'left': '', 'right': ''},
	  \ 'subseparator': {'left': '|', 'right': '|'},
      \ }

"####### Plugin : quickhl.vim #######
let g:quickhl_manual_hl_priority = 10 " プライオリティの設定
" let g:quickhl_cword_enable_at_startup = 1 " カーソル下の単語を一時的にハイライト
" 色指定(同時に個数も指定)
let g:quickhl_manual_colors = [
	\ "gui=bold ctermbg=Cyan    ctermfg=Black guibg=#8CCBEA guifg=Black",
	\ "gui=bold ctermbg=Green   ctermfg=Black guibg=#A4E57E guifg=Black",
	\ "gui=bold ctermbg=Yellow  ctermfg=Black guibg=#FFDB72 guifg=Black",
	\ "gui=bold ctermbg=Red     ctermfg=Black guibg=#FF7272 guifg=Black",
	\ "gui=bold ctermbg=Magenta ctermfg=Black guibg=#FFB3FF guifg=Black",
	\ "gui=bold ctermbg=Blue    ctermfg=Black guibg=#9999FF guifg=Black",
\ ]
" ハイライトショートカット
nmap m <Plug>(quickhl-manual-this)
vmap m <Plug>(quickhl-manual-this)
" 表示トグル
nmap <F8> <Plug>(quickhl-manual-toggle)
" ハイライトを削除
nmap M <Plug>(quickhl-manual-reset)
vmap M <Plug>(quickhl-manual-reset)

"####### Plugin : caw.vim #######
" コメントアウトのショートカット
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

" jedi-vim
" autocmd FileType python setlocal omnifunc=jedi#completions
" autocmd FileType python setlocal completeopt-=preview
" let g:jedi#popup_select_first = 0
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" " disable showing function arguments in upper line
" let g:jedi#show_call_signatures = 2
" " non-auto close preview window
" let g:jedi#auto_close_doc = 0

" tern_for_vim
au FileType javascript nmap <silent> <c-t> :TernType<CR>
au FileType javascript nmap <silent> <Leader>d :TernDoc<CR>
let g:tern_show_signature_in_pum = 1
let g:tern#command = ["nodejs", expand('$HOME').'/.vim/bundle/tern_for_vim/node_modules/tern/bin/tern', '--no-port-file'] " for Ubuntu command

" omni補完 omnifunc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType c set omnifunc=ccomplete#Complete
" autocmd FileType cpp set omnifunc=cppcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType cs set omnifunc=OmniSharp#Complete
" autocmd FileType python setlocal omnifunc=jedi#completions

" omni補完 input_pattern
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources#omni#input_patterns.javascript = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

" omni補完 force_input_pattern
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*' // this one
" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

