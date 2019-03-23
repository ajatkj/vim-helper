" =============================================================================
" Filename: helper.vim
" Author: Ankit Jain <ajatkj@yahoo.co.in>
" Desc: Providing helping functions for many plugins
" Last Change: 2018/09/10
" Dependency: none
" Revision History
" Ankit Jain     2018/09/10     Compatibility of openinsplit for older versions
"                               of Vim
" Ankit Jain     2018/10/11     helper#echo function for qf windows
" Ankit Jain     2018/12/15     New: functions randomize and init
" Ankit Jain     2018/03/20     New: functions str2list & rpad
" =============================================================================
"
if exists('g:loaded_helper') || v:version < 702
   finish
endif

let g:loaded_helper=1

" Echo msg with highlighting
function! helper#echo(msg,...)
   if &ft == 'qf'
      let progname=split(getline('.'),'|')[0]
   else
      let progname=expand('%:t')
   endif
   let text='"'.progname.'" '.a:msg
   if a:0 > 0
      if a:1 == 'w'
         let color='WarningMsg'
      elseif a:1 == 'e'
         let color='ErrorMsg'
      else
         let color='None'
      endif
   else
      let color='None'
   endif
   echohl color
   echomsg text
   echohl None
endfunction

" Open a file (full name) in a vertical split window and jump
" to a specific pattern if given
function! helper#openinsplit(filename,...)
   " open the same window if already exists
   let wins=[]
   let winf=-1
   if exists("*win_findbuf") " if win_findbuf is supported
      let wins=win_findbuf(bufnr(a:filename))
   else " if win_findbuf is not supported, use the longer route
      let currwin=winnr()
      let thiswin=-1
      keepjumps execute 'wincmd w'
      while currwin != thiswin
         let thiswin=winnr()
         if a:filename == expand('%:p')
            let winf=thiswin
         endif
         keepjumps execute 'wincmd w'
      endwhile
   endif
   " if window is found using win_findbuf
   if wins != []
      call win_gotoid(wins[0])
   " if window is found using wincmd w
   elseif winf > 0
      execute winf.'wincmd w'
   " if window is not found, open a new vertical split window
   else
      let curnr= winnr()
      exe "10wincmd l"
      if winnr() != curnr
         exe "bdelete!"
      endif
      exe "rightbelow vnew ". a:filename
   endif
   " if jump criteria is given in the call
   if a:0 == 1
      keepjumps normal! gg
      call search(a:1,'w')
      " make current line center of the screen
      normal! zz
   endif
endfunction

" Random number generator
function! helper#randomize(max) abort
   return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % a:max
endfunction

" Get the row and col of visual block
function! helper#getvisualblock()
   if mode()=="v"
      let [linestart, colstart] = getpos("v")[1:2]
      let [lineend, colend] = getpos(".")[1:2]
   else
      let [linestart, colstart] = getpos("'<")[1:2]
      let [lineend, colend] = getpos("'>")[1:2]
   end
   if (line2byte(linestart)) > (line2byte(lineend))
      let [linestart, colstart, lineend, colend] = [lineend, colend, linestart, colstart]
   end
   return [linestart, colstart, lineend, colend]
endfunction

" Convert a string (which was converted from list to string) back to list
function! helper#str2list(str)
   let string=a:str
   " below 3 subs are used convert string (of list) back to list
   let string=substitute(string,"', '","|","g")
   let string=substitute(string,"['","","g")
   let string=substitute(string,"']","","g")
   return split(string,"|")
endfunction

" Right pad text with spaces upto length
function! helper#rpad(text,len)
    return a:text . repeat(' ',a:len - len(a:text))
endfunction

" Dummy function to be called from a plugin to check if helper is installed
" and exit gracefully if not
function! helper#init()
   return
endfunction

