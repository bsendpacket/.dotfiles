{ pkgs, lib, ... }:

let
  acceptAllIpsScriptUrl = "https://raw.githubusercontent.com/REMnux/distro/master/files/accept-all-ips";
  acceptAllIpsScriptSha256 = "de331c34a0e9f152bf96b9cee73907590f7a2416524c11a9c357415def50cee9";

  mynicScriptUrl = "https://raw.githubusercontent.com/REMnux/distro/master/files/mynic";
  mynicScriptSha256 = "7a6df684806e65a35d62c72542ccdf41e6c75b7456716e34f7d6b3771b580d36";

  # Fetch the accept-all-ips script
  acceptAllIps = pkgs.fetchurl {
    url = acceptAllIpsScriptUrl;
    sha256 = acceptAllIpsScriptSha256;
  };

  # Fetch the mynic script
  mynic = pkgs.fetchurl {
    url = mynicScriptUrl;
    sha256 = mynicScriptSha256;
  };
in
{
  # Add scripts to home packages
  home.packages = with pkgs; [
    (writeShellScriptBin "accept-all-ips" ''
      #!${stdenv.shell}
      ${stdenv.shell} ${lib.escapeShellArg acceptAllIps} "$@"
    '')
    (writeShellScriptBin "mynic" ''
      #!${stdenv.shell}
      exec ${stdenv.shell} ${lib.escapeShellArg mynic} "$@"
    '')
  ];
}
