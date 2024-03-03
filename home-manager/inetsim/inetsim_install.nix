{ lib, stdenv, fetchurl, perl, makeWrapper, perlPackages, systemd }:

let
  # Import ipcShareable, which should already include mockSub if set up correctly
  ipcShareable = import ../perl/ipc-shareable.nix {
    inherit lib stdenv fetchurl perl makeWrapper perlPackages;
  };
  mockSub = import ../perl/mocksub.nix {
    inherit lib stdenv fetchurl perl makeWrapper perlPackages;
  };
  inetsimService = fetchurl {
    url = "https://aur.archlinux.org/cgit/aur.git/plain/inetsim.service?h=inetsim";
    sha256 = "eb4d884436e816c4e7c507bc5152a394bf30ea47767a183b514394c0b35e5078";
  };
in
stdenv.mkDerivation rec {
  pname = "inetsim";
  version = "1.3.2";

  src = fetchurl {
    url = "https://www.inetsim.org/downloads/${pname}-${version}.tar.gz";
    sha256 = "65e25abc94851b0054183670ee351a7a12f4863f4289ac0a56baf7457d5fdb4c";
  };

  nativeBuildInputs = [ perl makeWrapper ];
  buildInputs = [ systemd ]
    ++ (with perlPackages; [
      NetServer NetDNS DigestSHA1 IOSocketSSL JSON StringCRC32
    ]) ++ [ ipcShareable ]; # Include ipcShareable here as a build input

  dontBuild = true;

  unpackPhase = ''
    echo "Unpacking ${src}..."
    tar -xzf ${src} -C .
    echo "Unpacked source to: $(pwd)"
  '';

  installPhase = ''
    # Navigate to the unpacked source directory
    cd inetsim-${version}

    # Now, operations are relative to the source directory
    mkdir -p $out/opt/inetsim
    mkdir -p $out/usr/lib/systemd/system
    mkdir -p $out/usr/share/man/man1
    mkdir -p $out/usr/share/man/man5

    # Copying files from the current directory, which is the unpacked source
    cp -r . $out/opt/inetsim/

    # Assuming inetsim is directly in the unpacked source and needs path adjustment
    sed -i "s|./lib|$out/opt/inetsim/lib|" $out/opt/inetsim/inetsim

    # Adjust the paths for these files if they are located within subdirectories
    install -Dm644 ${inetsimService} $out/usr/lib/systemd/system/inetsim.service
    install -Dm644 man/man1/inetsim.1 $out/usr/share/man/man1/
    install -Dm644 man/man5/inetsim.conf.5 $out/usr/share/man/man5/

    # Wrap the executable
    # makeWrapper $out/opt/inetsim/inetsim $out/bin/inetsim

    makeWrapper $out/opt/inetsim/inetsim $out/bin/inetsim \
      --set PERL5LIB "${ipcShareable}/lib/perl5/site_perl/5.38.2:${mockSub}/lib/perl5/site_perl/5.38.2:$(nix-build -A perlPackages.NetServer)/lib/perl5/site_perl/5.38.2:$(nix-build -A perlPackages.NetDNS)/lib/perl5/site_perl/5.38.2"
  '';

  meta = with lib; {
    description = "Internet Services Simulation Suite";
    homepage = "https://www.inetsim.org";
    license = licenses.gpl2;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}

