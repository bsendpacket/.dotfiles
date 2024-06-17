{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    # Remove or adapt the imports based on availability on your Debian system
    /home/kbalint/.dotfiles/home-manager/kitty/kitty.nix
    #/home/kbalint/.dotfiles/home-manager/alacritty/alacritty.nix
    /home/kbalint/.dotfiles/home-manager/zsh/zsh.nix
    /home/kbalint/.dotfiles/home-manager/i3/i3.nix
    /home/kbalint/.dotfiles/home-manager/git/git.nix
    /home/kbalint/.dotfiles/home-manager/zoxide/zoxide.nix
    #/home/kbalint/.dotfiles/home-manager/spotifyd/spotifyd.nix
    /home/kbalint/.dotfiles/home-manager/yazi/yazi.nix
    /home/kbalint/.dotfiles/home-manager/zathura/zathura.nix
    /home/kbalint/.dotfiles/home-manager/rofi/rofi.nix
    #/home/kbalint/.dotfiles/home-manager/neovim/neovim.nix

    # Services
    /home/kbalint/.dotfiles/home-manager/picom/picom.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "kbalint";
    homeDirectory = "/home/kbalint";

    packages = with pkgs; [
      kitty
      #alacritty

      git
      zsh-fast-syntax-highlighting

      oh-my-zsh
      thefuck

      _7zz
      ouch
      htop
      glances

      neofetch
      glow
      
      # Social
      chromium
      spotifyd
      discord

      # Utilities
      xclip
      xdragon

      bat
      lsd
      zoxide
      fzf
      fd
      ripgrep
      jq
      yazi
      hexyl
      ueberzugpp

      rofi
      inxi

      ffmpegthumbnailer
      unar
      poppler

      tmux
      lazygit

      # Custom Python environment
      (python311.withPackages (ps: with ps; [
        requests
        flask
        netifaces
        mitmproxy
        construct
      ]))

      dive
      distrobox
      podman-tui
      podman-compose

      # Fonts
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
