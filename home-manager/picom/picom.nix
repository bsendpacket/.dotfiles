{ pkgs, ... }: {
  # Enable Picom service to enable transparacy
  services.picom = {
    enable = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.8;

    opacityRules = [ "100:class_g *?= 'Rofi'" ];

    settings = {
      corner-radius = 8;
    };
  };
}
