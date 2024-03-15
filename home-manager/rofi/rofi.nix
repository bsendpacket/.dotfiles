{ pkgs, ... }: {

  programs.rofi = {
    enable = true;
    terminal = "alacritty";
    theme = "~/.dotfiles/home-manager/rofi/theme.rasi";
  };
}
