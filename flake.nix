{
  description = "Development environment for ClaudeDeck";

  # Keep this pinned to the same nixpkgs revision as the workstation's Home
  # Manager config, so shared tools exist once in /nix/store.
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            nodejs
            pnpm
            python3
          ];
        };
      });
    };
}
