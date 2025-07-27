{
  description = "flake.nix for QwicClick-App Environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "QwC";
        buildInputs = with pkgs; [
          nodejs
        ];
        PORT = "3310";
      };
    };
}
