{ lib, pkgs, ... }:


{
  programs.noctalia = {
    enable = true;
    settings = ../../../config/noctalia/noctalia-config.toml;
  };
}
