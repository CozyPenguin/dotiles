# Imports
# use commands.nu

# Theming

# Seasons Winter

let seasons_bg0 = "#16181D";
let seasons_bg1 = "#2B303B";
let seasons_bg2 = "#414958";
let seasons_bg3 = "#576175";

let seasons_fg0 = "#A6B7D9";
let seasons_fg1 = "#C9D4E8";
let seasons_fg2 = "#EDF1F7";


let seasons_red0 = "#AE3743";
let seasons_red1 = "hsl(354, 52%, 35%)";
let seasons_red2 = "#D47781";
let seasons_red3 = "hsl(354, 52%, 70%)";

let seasons_orange0 = "hsl(35, 55%, 45%)";
let seasons_orange1 = "hsl(35, 55%, 35%)";
let seasons_orange2 = "hsl(35, 55%, 65%)";
let seasons_orange3 = "hsl(35, 55%, 70%)";

let seasons_yellow0 = "hsl(60, 55%, 45%)";
let seasons_yellow1 = "hsl(60, 55%, 35%)";
let seasons_yellow2 = "hsl(60, 55%, 65%)";
let seasons_yellow3 = "hsl(60, 55%, 70%)";

let seasons_green0 = "hsl(141, 71%, 45%)";
let seasons_green1 = "hsl(141, 71%, 35%)";
let seasons_green2 = "hsl(141, 71%, 65%)";
let seasons_green3 = "hsl(141, 71%, 70%)";

let seasons_cyan0 = "hsl(193, 76%, 45%)";
let seasons_cyan1 = "hsl(193, 76%, 35%)";
let seasons_cyan2 = "hsl(193, 76%, 65%)";
let seasons_cyan3 = "hsl(193, 76%, 70%)";

let seasons_blue0 = "hsl(220, 70%, 45%)";
let seasons_blue1 = "hsl(220, 70%, 35%)";
let seasons_blue2 = "hsl(220, 70%, 65%)";
let seasons_blue3 = "hsl(220, 70%, 70%)";

let seasons_purple0 = "hsl(270, 50%, 45%)";
let seasons_purple1 = "hsl(270, 50%, 35%)";
let seasons_purple2 = "hsl(270, 50%, 65%)";
let seasons_purple3 = "hsl(270, 50%, 70%)";

let seasons_magenta0 = "hsl(290, 45%, 45%)";
let seasons_magenta1 = "hsl(290, 45%, 35%)";
let seasons_magenta2 = "hsl(290, 45%, 65%)";
let seasons_magenta3 = "hsl(290, 45%, 70%)";

let seasons_winter = {
  shape_garbage: { fg: $seasons_fg2 bg: $seasons_red0 attr: b }
}

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

# Config
$env.config = {
  show_banner: false
  history: {
    file_format: "sqlite"
  }
  color_config: $seasons_winter
  cd: {
    abbreviations: true
  }
  completions: {
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 100
      completer: $carapace_completer
    }
  }
  # Vi stuff
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
      event: { send: HistoryHintComplete }
    }
  ]
}

# custom commands
def cz [] {
  git cz c
  git commit --amend --no-edit -S
}

# Aliases
alias cat = bat --paging=never # bat -> cat
alias vim = nvim

# vim-like commands
alias ":q" = exit

# TODO: check if there is an alternative to this
# alias ":qa" = exit --now
