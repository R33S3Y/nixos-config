{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      pname = "deploy";
      version = "1.0";

      src = ./src;

      buildInputs = [
        pkgs.nlohmann_json
      ];

      nativeBuildInputs = [
        pkgs.gcc
      ];

      buildPhase = ''
        g++ main.cpp utils.cpp -o deploy \
          -std=c++20 \
          -I${pkgs.nlohmann_json}/include
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp deploy $out/bin/
      '';
    })
  ];
}
