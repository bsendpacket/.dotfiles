{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
      # Place any values that need to be handled by ~/.zshrc here, if they cannot be defined elsewhere
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /home/remnix/.dotfiles#remnix --impure";
      py = "python3";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./powerlevel10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-fast-syntax-highlighting";
	src = pkgs.zsh-fast-syntax-highlighting;
	file = "share/zsh/site-functions";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
    };
  };

}
