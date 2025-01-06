$env.config = {
	buffer_editor: "nvim"
	show_banner: false
	edit_mode: 'vi'
	color_config: {
		  shape_external: red
		  shape_external_resolved: green
		  shape_internalcall: green
		  shape_external_arg: white
	}
}

$env.PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND = ""
$env.PROMPT_INDICATOR = $"(ansi red_bold)\n❯ (ansi reset)"
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi red_bold)\nn (ansi reset)"
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi red_bold)\n❯ (ansi reset)"

alias ll = ls -l
alias c = clear
