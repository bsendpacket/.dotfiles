{ lib, stdenv, fetchurl, perl, makeWrapper, perlPackages }:

let
  mockSub = import ./mocksub.nix { inherit (perlPackages); inherit perlPackages fetchurl stdenv perl makeWrapper lib; };
in
perlPackages.buildPerlPackage rec {
  pname = "IPC-Shareable";
  version = "1.13";

  src = fetchurl {
    url = "https://cpan.metacpan.org/authors/id/S/ST/STEVEB/IPC-Shareable-${version}.tar.gz";
    sha256 = "456e665f72a3fb7ba5a8e70e321cfc9c8259defb3111b51940ad08cab9c00e6b";
  };

  buildInputs = [
    makeWrapper
    perlPackages.JSON
    perlPackages.StringCRC32
    mockSub # Add the imported mockSub here
    perlPackages.TestSharedFork
  ];
  propagatedBuildInputs = [ perl ];

  meta = with lib; {
    description = "Tie a variable to shared memory";
    homepage = "https://metacpan.org/release/IPC-Shareable";
    license = with licenses; [ gpl2 ]; # Ensure you have the correct license
    maintainers = with maintainers; [ ]; # Optionally add a maintainer here
    platforms = platforms.unix;
  };
}
