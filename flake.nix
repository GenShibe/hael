{
  description = "Hael is a CLI for giving you a nice and sweet message to remind you of how amazing you are.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    nixpkgs,
    self,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin" "i686-linux" "aarch64-linux" "aarch64-darwin"];
    pkgsForEach = nixpkgs.legacyPackages;
  in {
    packages = forAllSystems (system: {
      default = pkgsForEach.${system}.callPackage ./default.nix {};
    });

    devShells = forAllSystems (system: {
      default = pkgsForEach.${system}.callPackage ./shell.nix {};
    });
  };
}
