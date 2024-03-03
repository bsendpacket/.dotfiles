{ pkgs ? import <nixpkgs> {} }:

let
  perlWithCPANminus = pkgs.perl538.buildPerlPackage rec {
    name = "perl5.28.2-with-packages";
    buildInputs = [ pkgs.perl ];
    propagatedBuildInputs = [ pkgs.perlPackages.Appcpanminus ];
    preferNativeBuildInputs = true;
    meta = {
      description = "Perl with CPANminus and additional packages";
    };
  };
in
pkgs.mkShell {
  buildInputs = [ perlWithCPANminus ];
}

