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
	keybindings: [
		{
			name: fuzzy_history
			modifier: control
			keycode: char_r
			mode: [vi_insert vi_normal]
			event: {
				send: executehostcommand
				cmd: "commandline edit --replace (
					history
					  | get command
					  | reverse
					  | uniq
					  | str join (char -i 0)
					  | fzf --scheme=history --read0 --tiebreak=chunk --layout=reverse --preview-window='bottom:3:wrap' --bind alt-up:preview-up,alt-down:preview-down --height=30%
					  | decode utf-8
					  | str trim
				  )"
			}
		}
	]
	hooks: {
		pre_prompt: [{ ||
			if (which direnv | is-empty) {
				return
			}

			direnv export json | from json | default {} | load-env
			if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
				$env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
			}
	  }]
	}
}

$env.PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND = "\n"
$env.PROMPT_INDICATOR = $"(ansi red_bold)\n❯ (ansi reset)"
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi red_bold)\nn (ansi reset)"
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi red_bold)\n❯ (ansi reset)"

alias ll = ls -l
alias c = clear

source /home/max/.cache/zoxide/init.nu
source /home/max/.cache/carapace/init.nu
