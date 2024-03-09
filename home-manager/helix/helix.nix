{ pkgs, ... }: {

  programs.helix = {
    enable = true;
    extraPackages = [ pkgs.marksman ];
  };
}
