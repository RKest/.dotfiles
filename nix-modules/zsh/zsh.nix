{ pkgs, lib, config, ... }:
{
  options = {
    zoxide.enable = lib.mkEnableOption "enables zoxide";
    zsh.enable = lib.mkEnableOption "enables zsh";
    direnv.enable = lib.mkEnableOption "enables direnv";
  };

  config = lib.mkMerge [
    (lib.mkIf config.zoxide.enable {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = config.zsh.enable;
        options = [ "--cmd cd" ];
      };
    })

    (lib.mkIf config.direnv.enable {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };
    })

    (lib.mkIf config.zsh.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          ll = "ls -l";
          c = "clear";
          llc = "ls -la --color";
        };
        initExtra = ''
          if [ -n "''${commands[fzf-share]}" ]; then
            source "$(fzf-share)/key-bindings.zsh"
            source "$(fzf-share)/completion.zsh"
          fi

          source "/home/max/.dotfiles/nix-modules/zsh/.p10k.zsh"

          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          # bindkey  "^[[H"   beginning-of-line
          # bindkey  "^[[F"   end-of-line
          bindkey "\E[1~" beginning-of-line
          bindkey "\E[4~" end-of-line
        '';

        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];
      };
    })
  ];
}

