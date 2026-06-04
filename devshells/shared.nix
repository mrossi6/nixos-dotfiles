{
  lib,
  pkgs,
  system,
}:
let
  basePackages = with pkgs; [
    fd
    git
    just
    jq
    ripgrep
    zsh
    direnv
    nerd-fonts.commit-mono
  ];
in
{
  inherit basePackages;

  mkShell =
    {
      name,
      packages ? [ ],
      shellHook ? "",
      env ? { },
    }:
    pkgs.mkShell (
      {
        packages = basePackages ++ packages;
        shellHook = ''
          echo "Entering ${name} shell (${system})"
        ''
        + lib.optionalString (shellHook != "") shellHook
        + ''
          case $- in
            *i*)
              if [ -z "''${DIRENV_IN_ENVRC:-}" ] && [ -z "''${__NIXOS_DOTFILES_ZSH_ACTIVE:-}" ]; then
                export __NIXOS_DOTFILES_ZSH_ACTIVE=1

              fi
              ;;
          esac
        '';
      }
      // env
    );
}
