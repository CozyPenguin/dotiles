# Nushell Config file

# Config
let-env config = {
  edit_mode: vi
  keybindings: [
    {
      name: vi_up
      modifier: control
      keycode: char_k
      mode: vi_insert
      event: { send: up }
    }
    {
      name: vi_down
      modifier: control
      keycode: char_j
      mode: vi_insert
      event: { send: down }
    }
    {
      name: vi_right
      modifier: control
      keycode: char_l
      mode: vi_insert
      event: { send: right }
    }
  ]
}

# Aliases
alias cat = bat --paging=never # bat -> cat
alias vim = nvim

# :q -> exit because vim
alias ":q" = exit
