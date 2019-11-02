" 行数
set number
set noswapfile

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

filetype indent on     "拡張子にインデントを変更
set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする

" ENV
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config')      : $XDG_CONFIG_HOME
let $CACHE  = empty($XDG_CACHE_HOME)  ? expand('$HOME/.cache')       : $XDG_CACHE_HOME
let $DATA   = empty($XDG_DATA_HOME)   ? expand('$HOME/.local/share') : $XDG_DATA_HOME

" Load File
function! s:load(file) abort
  let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')
  if filereadable(s:path)
    execute 'source' fnameescape(s:path)
  endif
endfunction

call s:load('plugins')

