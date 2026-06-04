{
  inputs,
  pkgs,
  homeFlakeTarget,
  ...
}:
let
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
in
{
  imports = [
    ../programs/ghostty.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/shell.nix
    ../programs/zed.nix
    inputs.paneru.homeModules.paneru
  ];

  programs.zsh.shellAliases = {
    hms = ''home-manager switch --flake ~/repos/mirrors/nixos-dotfiles"#${homeFlakeTarget}"'';
  };

  home.packages = with pkgs; [
    lazygit
    home-manager
    tmux
    ripgrep
    direnv
    pi-coding-agent
  ];

  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = zscaler-pem;
    REQUESTS_CA_BUNDLE = combined-ca-bundle;
    SSL_CERT_FILE = combined-ca-bundle;
    CURL_CA_BUNDLE = combined-ca-bundle;
    NIX_SSL_CERT_FILE = combined-ca-bundle;
    GIT_SSL_CAINFO = combined-ca-bundle;
  };

  services.paneru = {
    enable = false;
    settings = {
      options = {
        focus_follows_mouse = false;
        mouse_follows_focus = true;
        preset_column_widths = [
          0.25
          0.33
          0.5
          0.66
          0.75
          0.8
        ];
        border_active_window = true;
        border_color = "#679D6B";
        border_width = 1.0;

        swipe_gesture_fingers = 4;

        animation_speed = 50;
      };

      bindings = {
        quit = "ctrl + alt - q";

        window_focus_west = "cmd - h";
        window_focus_east = "cmd - l";
        window_focus_north = "cmd - k";
        window_focus_south = "cmd - j";

        window_swap_west = "cmd + alt - h";
        window_swap_east = "cmd + alt - l";
        window_swap_north = "cmd + alt - k";
        window_swap_south = "cmd + alt - j";

        window_center = "alt - c";
        window_resize = "alt - r";
        window_shrink = "alt + shift - r";

        window_fullwidth = "alt - f";
        window_manage = "alt - v";

        window_stack = "alt - ]";
        window_unstack = "alt + shift - ]";

        window_equalize = "alt + shift - e";
      };
    };
  };
}
