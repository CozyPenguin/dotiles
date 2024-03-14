# Starship prompt
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# Carapace completer
mkdir ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
