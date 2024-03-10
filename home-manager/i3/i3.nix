{ pkgs, lib, ... }: {
  xsession = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;

      # TIP: Using 'rec' here allows us to utilize 'modifier' as a variable later on
      config = rec {

        modifier = "Mod1";
        terminal = "alacritty";
        bars = [];

        gaps = {
          inner = 10;
          smartBorders = "on";
        };
        
        window.border = 0;
        floating.border = 0;
        
        fonts = {
          names = ["CaskaydiaCove Nerd Font Mono" "FontAwesome 6"];
          style = "Light Semi-Condensed";
          size = 11.0;
        };

        # TIP: Utilizing `lib.mkOptionDefault` here allows us to keep all the defaults
        # and simply add new keybinds to the configuration.
        keybindings = lib.mkOptionDefault {
          
          # Vim-like keybindings for i3
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        };

      };
    };
  };

  # Enable Picom service to enable transparacy
  services.picom.enable = true;
}

