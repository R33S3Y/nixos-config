{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgsStable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    })
  ];
}
