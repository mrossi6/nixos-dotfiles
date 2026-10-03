{
  config,
  inputs,
  pkgs,
  homeFlakeTarget,
  ...
}:
let
  # Cherry-picked from a pinned nixpkgs rev (see flake.nix) since our main
  # nixpkgs is rolled back for darwin/ld64 stability; bump/revert the pin
  # deliberately in flake.nix as needed.
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
    ../programs/emacs.nix
    ../programs/fzf.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/shell.nix
    ../programs/yazi.nix
    ../programs/zed.nix
    inputs.pi.homeModules.default
  ];

  programs.pi.coding-agent = {
    enable = true;
  };

  # Use Zed's prebuilt macOS app; Home Manager still manages its settings,
  # keymaps, and extensions without building the nixpkgs Zed package.
  programs.zed-editor.package = null;

  programs.zsh.shellAliases = {
    hms = ''home-manager switch --flake ~/repos/mirrors/nixos-dotfiles"#${homeFlakeTarget}"'';
  };

  programs.zsh.oh-my-zsh.plugins = [
    "azure"
  ];

  home.packages = with pkgs; [
    home-manager
    fd
    yq
    pkgs-pinned.azure-cli  # 2.84.0 via pinned nixpkgs-pinned; 2.87.0+ has a JsonCTemplatePolicy key-order regression
    gh
    gh-dash
    lazygit
    nerd-fonts.commit-mono
    # ioskeley-mono-normal-Term-NF
    departure-mono
    tmux
    envchain
    ripgrep
    direnv
    zoxide
    btop
    whisper-cpp

    uv
    nodejs
    jdk
  ];

  home.file.".config/ghostty".source = ../../config/ghostty;
  home.file.".config/ssl/combined-ca-bundle.crt".source = combined-ca-bundle;

  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = zscaler-pem;
    REQUESTS_CA_BUNDLE = combined-ca-bundle-path;
    SSL_CERT_FILE = combined-ca-bundle-path;
    CURL_CA_BUNDLE = combined-ca-bundle-path;
    NIX_SSL_CERT_FILE = combined-ca-bundle-path;
    GIT_SSL_CAINFO = combined-ca-bundle-path;
    BUN_CONFIG_EXTRA_CA_CERTS = zscaler-pem;
    CARGO_HTTP_CAINFO = combined-ca-bundle-path;
  };

}
