{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            llvmPackages.openmp
            nushell
            atuin
          ];
          shellHook = ''
            if [ -f .env ]; then
              echo "Loading environment variables from .env ..."
              set -a
              source .env
              set +a
              echo "Done"
            fi

            export ATUIN_SESSION=$(atuin uuid)
            exec nu
          '';
        };
      }
    );
}

