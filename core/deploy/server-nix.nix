{ pkgs, inputs, ... }:
let
  version = "dev";
in
{
  # overlay deploy package. So that it can be package and accessed with pkgs.internal.deploy
  inputs.nixpkgs.overlays = [
    (final: prev: {
      internal = (prev.internal or { }) // {
        # prev.internal is their so we don't overwrite pkgs.internal

        deploy = prev.stdenv.mkDerivation {
          pname = "deploy";
          version = version;

          src = ./src;

          buildInputs = with prev; [
            nlohmann_json
            libtar
            libssh2
          ];

          nativeBuildInputs = with prev; [
            gcc
            pandoc
          ];

          buildPhase = ''
            g++ \
                server/main.cpp \
                utils/systemHelper.cpp utils/split.cpp utils/strings.cpp utils/ttyHelper.cpp utils/args.cpp utils/nixGet.cpp \
              -o deploy \
              -std=c++23 \
              -g \
              -I${prev.nlohmann_json}/include \
              -I${prev.libtar}/include \
              -L${prev.libtar}/lib -ltar \
              -I${prev.libssh2.dev}/include \
              -L${prev.libssh2}/lib -lssh2 \

            sed -i 's/version/\"${version}\"/' server/man.md
            pandoc server/man.md -s -t man -o deploy.1
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp deploy $out/bin/

            mkdir -p $out/share/man/man1
            cp deploy.1 $out/share/man/man1
          '';
        };
      };
    })
  ];

  environment.systemPackages = [ pkgs.internal.deploy ]; # install it.
}
