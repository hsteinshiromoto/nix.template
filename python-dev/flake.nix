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

        commonInputs = with pkgs; [
          llvmPackages.openmp
          atuin
        ];

        mkEnvHook = ''
          if [ -f .env ]; then
            echo "Loading environment variables from .env ..."
            set -a
            source .env
            set +a
            echo "Done"
          fi
        '';
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = commonInputs ++ [ pkgs.nushell ];
            shellHook = ''
              ${mkEnvHook}
              export ATUIN_SESSION=$(atuin uuid)
              exec nu
            '';
          };

          zsh = pkgs.mkShell {
            buildInputs = commonInputs;
            shellHook = ''
              ${mkEnvHook}
              export ATUIN_SESSION=$(atuin uuid)
              eval "$(atuin init zsh)"
              exec zsh
            '';
          };

          bash = pkgs.mkShell {
            buildInputs = commonInputs;
            shellHook = ''
              ${mkEnvHook}
              exec bash
            '';
          };
        };
      }
    );
}

