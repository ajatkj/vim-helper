# vim-helper
Vim generic helper functions used in my other plugins

## Functions

##### helper#echo
`echomsg` with highlighting for warning message, error message and information message.

```viml
call helper#echo('my message','e')
```

##### helper#openinsplit
Opens a file a vertical split window (or bring to front if already open) and jump to the pattern specified (if any).

```viml
call helper#openinsplit(file,'jump here')
```

##### helper#randomize
Generate a random number less than maximum value

```viml
let rand=helper#randomize(1000)
```

##### helper#getvisualblock
Get rows and columns for visual block selected or last selected

```viml
let [r1,c1,r2,c2]=helper#getvisualblock()
```

##### helper#str2list
Convert a string (which was converted to string from a list) back to list

```viml
let l=['this', 'is', 'a', 'list']
let s=string(l)
" do something with the string
let l=helper#str2list(s)
```
 
##### helper#rpad
Right pad text with spaces

```viml
let text=helper#rpad(text,25)
```

##### helper#init
Empty function to check if vim-helper is loaded and if not exit the plugin gracefully

```viml
" include below code at the start of any plugin using vim-helper
try
   call helper#init()
catch
   echom 'helper.vim required, not loading the plugin'
   call feedkeys(" ")
   finish
endtry
```

## Installation

You install vim-helper like any other vim plugin.

##### Pathogen

```
cd ~/.vim/bundle
git clone https://github.com/ajatkj/vim-helper.git
vim -u NONE -c "helptags vim-helper/doc" -c q
```

##### VimPlug

Place this in your .vimrc:

```viml
Plug 'ajatkj/vim-helper'
```

Then run the following in Vim:

```
:source %
:PlugInstall
```

##### No plugin manager

Copy vim-helper's subdirectories into your vim configuration directory:

```
cd /tmp && git clone git://github.com/ajatkj/vim-helper.git
cp -r vim-helper/* ~/.vim/
```

See `:help add-global-plugin`.
