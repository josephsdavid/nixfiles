with import <nixpkgs> {};
let customPlugins = {
  nvim-r = vimUtils.buildVimPlugin {
    name = "nvim-r";
    src = fetchgit {
      url= "https://github.com/jalvesaq/nvim-r";
 #     sha256 = "0ai0cr62gc7n6y22ki3qibyj1qnlaxv1miqxmmahfk3hpbyfqz9n";
 #sha256 = "0pyz20jjzbnayi2mdh2j3pg746ingdc7pvqsl2acwj93qbcmg4kq";
    sha256 = "15cajp6c4123mxcy8km0bzdpjl4q50h1wq9ah69x174s112c86ni";
      #sha256 = "06wi8xsp32bkym424zxv8daxvlnkcf8q2fqc5zwhh4hmbbgy7ixj";
#      sha256 = "1d1vsl6i9dgbwj5ay4b6fkzxza7pi6f9m0v3s9936xm43mg73mbm";
    #  sha256 = "1f7ha5sjjpdsj4qpimxdnbvw38vkp0c1jvnj1jcyid10dyg14y5k";
     # rev =  "c53b5a402a26df5952718f483c7461af5bb459eb";
     # sha256 = "13xbb05gnpgmyaww6029saplzjq7cq2dxzlxylcynxhhyibz5ibv";
      };
    buildInputs = [ which vim  zip];
  };
  vim-pandoc-syntax = vimUtils.buildVimPlugin {
    name = "vim-pandoc-syntax";
    src = fetchgit {
      url = "https://github.com/vim-pandoc/vim-pandoc-syntax";
      sha256 = "1dir9h6s63lr10ffaxlpjar0xfmmjr3nhhgijsaa0vgnghc00r7x";
    };
  };

  vim-processing =  vimUtils.buildVimPlugin {
    name = "vim-processing";
    src = fetchgit {
      url = "https://github.com/sophacles/vim-processing";
      sha256 = "1irnpc08wlwwbbi48glv31s35dgn7329cqnhap66m9byqzsqyz2y";
    };
  };
};
in vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
      set clipboard=unnamedplus
      autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
      autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
      autocmd FileType r setlocal expandtab shiftwidth=2 softtabstop=2
      autocmd FileType rmd setlocal expandtab shiftwidth=2 softtabstop=2
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
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
map <leader>nn :call ToggleNetrw()<cr>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
      let g:netrw_winsize = 25
      let g:vimtex_view_method = 'zathura'
      autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
      let g:vim_markdown_folding_disabled = 1
      let g:vim_markdown_conceal = 0
      let g:vim_markdown_conceal_code_blocks = 0
      nmap <leader>kk <Plug>RMakeAll
      let g:pymode_lint_on_write = 0
      let g:slime_target = "vimterminal"
      let g:slime_vimterminal_cmd = "ipython"
      let g:slime_python_ipython = 1
hi Bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi Conceal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Directory ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Ignore ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Italic ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE,italic gui=NONE,italic
hi ModeMsg ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi MoreMsg ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Question ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi NonText ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Normal ctermfg=240 ctermbg=231 guifg=#535c65 guibg=#fbffff guisp=NONE cterm=NONE gui=NONE
hi Terminal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Title ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
hi Underlined ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE,underline gui=NONE,underline
hi Comment ctermfg=243 ctermbg=NONE guifg=#6d7782 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi CursorLineNr ctermfg=243 ctermbg=NONE guifg=#6d7782 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi LineNr ctermfg=243 ctermbg=NONE guifg=#6d7782 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi FoldColumn ctermfg=240 ctermbg=NONE guifg=#535c65 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi PmenuSel ctermfg=240 ctermbg=231 guifg=#535c65 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi SignColumn ctermfg=240 ctermbg=NONE guifg=#535c65 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi StatusLine ctermfg=240 ctermbg=231 guifg=#535c65 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi StatusLineTerm ctermfg=240 ctermbg=231 guifg=#535c65 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi TabLineSel ctermfg=240 ctermbg=231 guifg=#535c65 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi VisualNOS ctermfg=243 ctermbg=231 guifg=#6d7782 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Cursor ctermfg=238 ctermbg=231 guifg=#434951 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi IncSearch ctermfg=238 ctermbg=231 guifg=#434951 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi ColorColumn ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi CursorLine ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi DiffChange ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi Folded ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi MatchParen ctermfg=238 ctermbg=249 guifg=#434951 guibg=#afb7c0 guisp=NONE cterm=NONE gui=NONE
hi Pmenu ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi QuickFixLine ctermfg=NONE ctermbg=255 guifg=NONE guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi StatusLineNC ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi StatusLineTermNC ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi TabLine ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi ToolbarButton ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE,bold gui=NONE,bold
hi WildMenu ctermfg=240 ctermbg=255 guifg=#535c65 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi PmenuSbar ctermfg=249 ctermbg=249 guifg=#afb7c0 guibg=#afb7c0 guisp=NONE cterm=NONE gui=NONE
hi PmenuThumb ctermfg=240 ctermbg=240 guifg=#535c65 guibg=#535c65 guisp=NONE cterm=NONE gui=NONE
hi TabLineFill ctermfg=255 ctermbg=255 guifg=#e5ebf1 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi ToolbarLine ctermfg=255 ctermbg=255 guifg=#e5ebf1 guibg=#e5ebf1 guisp=NONE cterm=NONE gui=NONE
hi VertSplit ctermfg=249 ctermbg=249 guifg=#afb7c0 guibg=#afb7c0 guisp=NONE cterm=NONE gui=NONE
hi SpellBad ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=#bc4d61 cterm=NONE,underline gui=NONE,undercurl
hi SpellCap ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=#007cc3 cterm=NONE,underline gui=NONE,undercurl
hi SpellLocal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=#008787 cterm=NONE,underline gui=NONE,undercurl
hi SpellRare ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=#965dae cterm=NONE,underline gui=NONE,undercurl
hi StorageClass ctermfg=97 ctermbg=NONE guifg=#8f63a2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Structure ctermfg=97 ctermbg=NONE guifg=#8f63a2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Type ctermfg=97 ctermbg=NONE guifg=#8f63a2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Typedef ctermfg=97 ctermbg=NONE guifg=#8f63a2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi TooLong ctermfg=97 ctermbg=231 guifg=#8f63a2 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi WarningMsg ctermfg=97 ctermbg=231 guifg=#8f63a2 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Function ctermfg=131 ctermbg=NONE guifg=#ae5865 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Identifier ctermfg=131 ctermbg=NONE guifg=#ae5865 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi DiffDelete ctermfg=131 ctermbg=231 guifg=#ae5865 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi DiffRemoved ctermfg=131 ctermbg=231 guifg=#ae5865 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Error ctermfg=131 ctermbg=231 guifg=#ae5865 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi ErrorMsg ctermfg=131 ctermbg=231 guifg=#ae5865 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Debug ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Delimiter ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Special ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi SpecialChar ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi SpecialComment ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi SpecialKey ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Tag ctermfg=94 ctermbg=NONE guifg=#906c33 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi DiffChanged ctermfg=94 ctermbg=231 guifg=#906c33 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi DiffText ctermfg=94 ctermbg=231 guifg=#906c33 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Search ctermfg=179 ctermbg=238 guifg=#e5bb7e guibg=#434951 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Conditional ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Exception ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Keyword ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Label ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Operator ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Repeat ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Statement ctermfg=65 ctermbg=NONE guifg=#4d7f43 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi DiffAdd ctermfg=65 ctermbg=231 guifg=#4d7f43 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi DiffAdded ctermfg=65 ctermbg=231 guifg=#4d7f43 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Define ctermfg=30 ctermbg=NONE guifg=#008483 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Include ctermfg=30 ctermbg=NONE guifg=#008483 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Macro ctermfg=30 ctermbg=NONE guifg=#008483 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi PreCondit ctermfg=30 ctermbg=NONE guifg=#008483 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi PreProc ctermfg=30 ctermbg=NONE guifg=#008483 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Todo ctermfg=30 ctermbg=231 guifg=#008483 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
hi Boolean ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Character ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Constant ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Float ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Number ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi String ctermfg=32 ctermbg=NONE guifg=#2b7ab2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
hi Visual ctermfg=32 ctermbg=231 guifg=#2b7ab2 guibg=#fbffff guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    '';
    # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
            # Here you can place all your vim plugins
            # They are installed managed by `vam` (a vim plugin manager)
            "repeat"
            "auto-pairs"
            "Syntastic"
            "vim-nix"
            "surround"
#            "nerdtree"
            "vim-markdown"
            "vim-fugitive"
            "vimtex"
            "vim2hs"
            "vim-processing"
            "ctrlp"
            "goyo"
            "python-mode"
            "nvim-r"
            "vim-slime"
            "vim-scala"
#            "vim-pandoc-syntax"
            #"csv"
        ]; }
    ];
}
