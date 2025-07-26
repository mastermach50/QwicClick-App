# shell.nix for JS Environment
{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "JS";
  packages = with pkgs; [
    nodejs
    pnpm
  ];
}
