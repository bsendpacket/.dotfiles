{ lib, stdenv, fetchurl, perl, makeWrapper, perlPackages }:

perlPackages.buildPerlPackage rec {
  pname = "Mock-Sub";
  version = "1.09";
  src = fetchurl {
    url = "https://cpan.metacpan.org/authors/id/S/ST/STEVEB/Mock-Sub-${version}.tar.gz";
    sha256 = "86ac0ff242e712df040c559aa0dcb871914d92f4b86977cf1402b6f8131a9c10";
  };

  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ perl ];

  doCheck = true;

  meta = with lib; {
    description = "Mock::Sub - A module to mock subroutines in Perl";
    homepage = "https://metacpan.org/pod/Mock::Sub";
    license = with licenses; [ artistic2 ]; # This is a common license for Perl modules, but verify it
    maintainers = with maintainers; [ ]; # Add yourself or leave empty
    platforms = platforms.unix;
  };
}

