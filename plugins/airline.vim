let g:airline_theme = 'virtualenv'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1

nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <A-q> :bdelete<CR>
nnoremap <A-1> :bfirst<CR>
nnoremap <A-2> :b2<CR>:bnext<CR>
nnoremap <A-3> :b3<CR>:2bnext<CR>
nnoremap <A-4> :b4<CR>:3bnext<CR>
nnoremap <A-5> :b5<CR>:4bnext<CR>
nnoremap <A-6> :b6<CR>:5bnext<CR>
nnoremap <A-7> :b7<CR>:6bnext<CR>
nnoremap <A-8> :b8<CR>:7bnext<CR>
nnoremap <A-9> :b9<CR>:8bnext<CR>
nnoremap <A-0> :blast<CR>
