# Prompt indicator
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ""
let-env PROMPT_INDICATOR_VI_NORMAL = ""

# Oh My Posh
let posh_theme = ( '~/.config/oh-my-posh/' | path join 'theme.omp.json' )
let width = (term size -c | get columns | into string)
let-env PROMPT_MULTILINE_INDICATOR = (oh-my-posh print secondary $"--config=($posh_theme)" "--shell=nu" )
let-env PROMPT_COMMAND_RIGHT = { oh-my-posh print right $"--config=($posh_theme)" $"--terminal-width=($width)" }
let-env PROMPT_COMMAND = { oh-my-posh print primary $"--config=($posh_theme)" $"--execution-time=($env.CMD_DURATION_MS)" $"--error=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)" }

