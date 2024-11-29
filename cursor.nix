{
  inputs,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
in {

   environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
}
