# Prompt indicator
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

# Starship
$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_SESSION_KEY = (random chars -l 16)
$env.PROMPT_MULTILINE_INDICATOR = (^starship prompt --continuation)

$env.PROMPT_COMMAND = { ||
    # jobs are not supported
    let width = ((term size).columns | into string)
    ^starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
}

# Not well-suited for `starship prompt --right`.
# Built-in right prompt is equivalent to $fill$right_format in the first prompt line.
# Thus does not play well with default `add_newline = True`.
$env.PROMPT_COMMAND_RIGHT = {||''}

