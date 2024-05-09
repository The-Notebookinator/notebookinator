{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    typstfmt.url = "github:astrale-sharp/typstfmt/0.2.7";

    typstfmt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , typstfmt
    ,
    }:
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell = pkgs.mkShell {
        packages = [
          pkgs.typst
          pkgs.typst-lsp
          typstfmt.packages.${system}.default
          pkgs.act
          pkgs.nodePackages_latest.prettier
          pkgs.just
          pkgs.mdbook
        ];
      };

    });
}
