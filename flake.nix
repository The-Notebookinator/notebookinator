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
      mdbook-typst-doc = pkgs.rustPlatform.buildRustPackage  rec {
        pname = "mdbook-typst-doc";
        version = "0.1.2";

        src = pkgs.fetchFromGitHub {
          owner = "fenjalien";
          repo = pname;
          rev = version;
          sha256 = "sha256-GulEn/MSiE8su0k+VL3uNslYCbjLJnmW6rMOdTQSMUw=";
        };
      
        cargoHash = "sha256-KD6J8dTIPaII4ISh0PW6u1EMj5JVEDYcXuZ75ycbSys=";
      };
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
          pkgs.mdbook-admonish
          mdbook-typst-doc
        ];
      };

    });
}
