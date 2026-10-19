{ config, inputs, pkgs, ... }:

let
  pkgs-pinned = inputs.nixpkgs-pinned.legacyPackages.${pkgs.stdenv.hostPlatform.system};

  zscaler-cert-raw = builtins.fetchurl {
    url = "https://kmxprodzscalercerts.blob.core.windows.net/zscalercerts/zscaler_root_ca.crt";
    sha256 = "0a7g3f8wg87gk6r98qwsa54s8vf16bgkyy4d4hzkccw3kl3wp734";
  };

  # Extract the PEM block from the openssl text dump
  zscaler-pem = pkgs.runCommand "zscaler-root-ca.pem" { } ''
    ${pkgs.gnused}/bin/sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' \
      ${zscaler-cert-raw} > $out
    '';

  # Combined CA bundle: Mozilla CAs + Zscaler root
  combined-ca-bundle = pkgs.runCommand "combined-ca-bundle.crt" { } ''
    cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt > $out
    echo "" >> $out
    echo "# Zscaler Root CA" >> $out
    cat ${zscaler-pem} >> $out
  '';

  combined-ca-bundle-path = "${config.home.homeDirectory}/.config/ssl/combined-ca-bundle.crt";
  in
{
  imports = [
    ../../home/desktops/n3
    ../../home/programs/emacs.nix
    ../../home/programs/fzf.nix
    ../../home/programs/git.nix
    ../../home/programs/neovim.nix
    ../../home/programs/shell.nix
    ../../home/programs/yazi.nix
    inputs.pi.homeModules.default
  ];

  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "26.05";

  home.file.".config/ghostty".source = ../../config/ghostty;
}
