# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # TODO: Investigate what this actually does?
    inputs.nix-colors.homeManagerModule

    # Grab Scripts from Internet
    #./misc/scripts.nix

    # Neovim for Nix
    inputs.nixvim.homeManagerModules.nixvim

    # Configurations
    /home/remnix/.dotfiles/home-manager/kitty/kitty.nix
    #/home/remnix/.dotfiles/home-manager/alacritty/alacritty.nix
    /home/remnix/.dotfiles/home-manager/zsh/zsh.nix
    /home/remnix/.dotfiles/home-manager/i3/i3.nix
    /home/remnix/.dotfiles/home-manager/git/git.nix
    /home/remnix/.dotfiles/home-manager/zoxide/zoxide.nix
    #/home/remnix/.dotfiles/home-manager/spotifyd/spotifyd.nix
    /home/remnix/.dotfiles/home-manager/yazi/yazi.nix
    /home/remnix/.dotfiles/home-manager/zathura/zathura.nix
    /home/remnix/.dotfiles/home-manager/rofi/rofi.nix
    /home/remnix/.dotfiles/home-manager/neovim/neovim.nix

    # Services
    /home/remnix/.dotfiles/home-manager/picom/picom.nix
  ];

  nixpkgs = {
  
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  
    # Configure nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "remnix";
    homeDirectory = "/home/remnix";
    file.".background-image" = {
      source = "/home/remnix/.dotfiles/.wallpaper";
    };

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
      #spotify-tui # This package was apparently unmaintained. Need to find a workaround?
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
	textual
	textual-dev
      ]))

      dive
      distrobox
      podman

      xorg.xhost

      # Fonts
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];

    # If a file ever has to be mapped to a destination, this is an example:
    # file = {
    #   ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    # };
    # To be clear, you should _not_ do this for a zsh plugin. This is just an example. Put the plugin info into zsh.nix!

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "23.11";
  };

  # Anything more than a few lines should be moved to another file!
  programs = {
    home-manager = {
      enable = true;
    };

  };
}
