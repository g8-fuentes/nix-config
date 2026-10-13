{ inputs, ... }: {

  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (_: flake:
      let
        legacyPackages = (flake.legacyPackages or { }).${final.stdenv.hostPlatform.system} or { };
        packages = (flake.packages or { }).${final.stdenv.hostPlatform.system} or { };
      in if legacyPackages != { } then legacyPackages else packages) inputs;
  };
  unstable-packages = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };

  modifications = final: prev: {
    nchat = prev.nchat.overrideAttrs (old: rec {
      version = "4.41";
      pname = "nchat";
      src = prev.fetchFromGitHub {
        owner = "d99kris";
        repo = pname;
        rev = "v${version}";
        hash = "sha256-P+QprQDXUv5uCa/6+RXYImWDL0DIG+p8KFiGPwK+q0g=";
      };
      cmakeFlags = [ ];
    });

  };

  neorg = inputs.neorg-overlay.overlays.default;
}
