{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      pname = "deploy";
      version = "1.0";

      src = ./.;

      buildInputs = [
        pkgs.nlohmann_json
      ];

      nativeBuildInputs = [
        pkgs.gcc
      ];

      buildPhase = ''
        g++ deploy.cpp -o deploy \
          -std=c++20 \
          -I${pkgs.nlohmann_json}/include
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp getDeviceId $out/bin/
      '';
    })
  ];
}
