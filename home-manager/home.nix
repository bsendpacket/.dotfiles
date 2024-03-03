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
    ./misc/scripts.nix

    # Configurations
    ./alacritty/alacritty.nix
    ./zsh/zsh.nix
    ./neovim/neovim.nix
    ./i3/i3.nix
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

    packages = with pkgs; [
      alacritty
      git
      zsh-fast-syntax-highlighting

      oh-my-zsh
      thefuck

      _7zz
      wireshark
      openssl

      # Utilities
      xclip
      xdragon

      # Custom Python environment
      (python311.withPackages (ps: with ps; [
        requests
        flask
	netifaces
	mitmproxy
	construct
      ]))

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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Anything more than a few lines should be moved to another file!
  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
    };
  };
}
