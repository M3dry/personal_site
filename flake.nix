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
      overlay = final: prev: let
        inherit (prev.personal_site) buildPhase buildInputs;
      in {
        personal_site = prev.personal_site.override {
          preBuild = ''
            tailwindcss -o ./static/out.css
          '';
          buildInputs = [pkgs.nodePackages_latest.tailwindcss] ++ buildInputs;
          preInstall = ''
          mkdir -p $out
          cp -r ./static $out/
          '';
        };
      };
    in {
      legacyPackages = scope.overrideScope' overlay;

      packages.default = self.legacyPackages.${system}.${package};
    });
}
