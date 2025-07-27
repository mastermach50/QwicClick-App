# shell.nix for QwicClick-App Environment
{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "QwC";
  packages = with pkgs; [
    nodejs
  ];
  PORT = "3310";
}
