with import <nixpkgs> {};
let customPlugins = {
  nvim-r = vimUtils.buildVimPlugin {
    name = "nvim-r";
    src = fetchgit {
      url= "https://github.com/jalvesaq/nvim-r";
      rev =  "c53b5a402a26df5952718f483c7461af5bb459eb";
      sha256 = "13xbb05gnpgmyaww6029saplzjq7cq2dxzlxylcynxhhyibz5ibv";
      };
    buildInputs = [ which vim  zip];
  };
};
in vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
      set relativenumber
      set number
      set backspace=indent,eol,start
      set mouse=
      set history=500
      filetype plugin on
      filetype indent on
      set autoread
      let mapleader = ","
      nmap <leader>w :w!<cr>
      set so=7
      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      set lazyredraw
      set magic
      set foldcolumn=1
      syntax enable
      set encoding=utf8
      set nobackup
      set nowb
      set noswapfile
      map <space> /
      map <c-space> ?
      map <C-j> <C-W>j
      map <C-k> <C-W>k
      map <C-h> <C-W>h
      map <C-l> <C-W>l
      map <leader>tn :tabnew<cr>
      map <leader>to :tabonly<cr>
      map <leader>tc :tabclose<cr>
      map <leader>tm :tabmove
      map <leader>t<leader> :tabnext
      let g:lasttab = 1
      nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
      au TabLeave * let g:lasttab = tabpagenr()
      set laststatus=2
      set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
      map 0 ^
      fun! CleanExtraSpaces()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        silent! %s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
      endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
        endif
        vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
        inoremap $4 {<esc>o}<esc>O
        iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
        let g:NERDTreeWinPos = "left"
      let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
      let g:multi_cursor_quit_key = '<Esc>'
      vmap Si S(i_<esc>f)
"let g:vimtex_view_method = 'zathura'
    '';
    # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
            # Here you can place all your vim plugins
            # They are installed managed by `vam` (a vim plugin manager)
            "auto-pairs"
            "Syntastic"
            "vim-nix"
            "surround"
            "nerdtree"
            "vim-markdown"
            "vim-multiple-cursors"
            "vim-fugitive"
            #"vimtex"
            "ctrlp"
            "goyo"
            "nvim-r"
        ]; }
    ];
}
