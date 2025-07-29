{
  description = "flake.nix for QwicClick-App";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      PORT = "3310";
    in
    {
      packages.${system}.default = pkgs.buildNpmPackage {
        pname = "qwic-click-app";
        version = "0.0.1";
        description = "The QwicClick Web App";

        src = ./.;
        npmDepsHash = "sha256-sehJGc8cy3ctORl1gZGyYEUgqWFS2xqlKqUq3LuOIAk=";

        inherit PORT;

        buildInputs = with pkgs; [
          nodejs
        ];

        installPhase = ''
          mkdir -p $out/bin
          cat > $out/bin/qwic-click-app << EOF
          #!${pkgs.bash}/bin/bash
          export PORT=${PORT}
          ${pkgs.nodejs}/bin/node build
          EOF
          chmod +x $out/bin/qwic-click-app
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        name = "QwC";
        buildInputs = with pkgs; [
          nodejs
        ];
        inherit PORT;
      };
    };
}
