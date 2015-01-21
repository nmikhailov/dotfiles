" VAM initialization 
set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" ACTIVATING PLUGINS
call vam#ActivateAddons([ 'sensible' ], {})
call vam#ActivateAddons([ 'github:tomtom/tcomment_vim' ], {})
call vam#ActivateAddons([ 'fugitive' ], {})
call vam#ActivateAddons([ 'vim-airline' ], {})
let g:airline#extensions#tabline#enabled = 1
call vam#ActivateAddons([ 'github:kien/ctrlp.vim' ], {})
call vam#ActivateAddons([ 'github:ervandew/supertab' ], {})
call vam#ActivateAddons([ 'github:scrooloose/nerdtree' ], {})
map <C-n> :NERDTreeToggle<CR>
call vam#ActivateAddons([ 'github:digitaltoad/vim-jade' ], {})

" TWEAKS
set nopaste
imap jj <Esc>
set number " line numbers

set undofile
set undodir=~/.tmp/vimundo/
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" indent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
