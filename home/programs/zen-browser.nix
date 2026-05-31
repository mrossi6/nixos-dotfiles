{ ... }:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  zen-extensions = [
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
  ];
in
{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    policies = {
      ExtensionSettings = builtins.listToAttrs zen-extensions;
    };
  };
}
