{
  inputs = {
    opam-nix.url = "github:tweag/opam-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.follows = "opam-nix/nixpkgs";
  };
  outputs = {
    self,
    flake-utils,
    opam-nix,
    nixpkgs,
  } @ inputs: let
    package = "personal_site";
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      on = opam-nix.lib.${system};
      scope =
        on.buildOpamProject {} package ./. {ocaml-base-compiler = "*";};
      overlay = final: prev: {
        personal_site = prev.personal_site.overrideAttrs (oldAttrs: rec {
          preBuild = ''
            tailwindcss -o ./static/out.css
          '';
          buildInputs = [pkgs.nodePackages_latest.tailwindcss] ++ oldAttrs.buildInputs;
          preInstall = ''
            mkdir -p $out
            cp -r ./static $out/
          '';
        });
      };
    in {
      legacyPackages = scope.overrideScope' overlay;

      packages.default = self.legacyPackages.${system}.${package};
      devShell = with opam-nix.inputs.nixpkgs.legacyPackages.${system};
        mkShell {inherit (self.legacyPackages.${system}.${package}) buildInputs;};
    });
}
