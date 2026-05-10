[
  {
    _class = "nixos";
    _file = "/nix/store/w6na21bl2lbllmnwiyxdlfv7gf26gn0v-source/flake.nix#nixosModules.stylix";
    imports = [
      {
        imports = [
          {
            _file = "/nix/store/w6na21bl2lbllmnwiyxdlfv7gf26gn0v-source/flake/modules.nix, via option flake.nixosModules.stylix";
          }
        ];
      }
    ];
  }
  /nixos/core/boot/bios-nix.nix
  /nixos/core/boot/style-nix.nix
  /nixos/core/btop/enable-nix.nix
  /nixos/core/fastfetch/enable-nix.nix
  /nixos/core/lazyUpdate/enable-nix.nix
  /nixos/desktop/pcmanfm/enable-nix.nix
  /nixos/core/rofi/enable-nix.nix
  /nixos/core/style/stylix-nix.nix
  /nixos/core/other/cmd-nix.nix
  /nixos/core/home/home-nix.nix
  /nixos/core/other/journald-nix.nix
  /nixos/core/other/local-nix.nix
  /nixos/core/other/networking-nix.nix
  /nixos/core/other/nix-nix.nix
  /nixos/core/other/programs-nix.nix
  /nixos/core/other/ssh-nix.nix
  /nixos/core/other/sudo-nix.nix
  /nixos/core/other/user-nix.nix
  /nixos/services/minecraft/minecraft-nix.nix
  /nixos/services/minecraft/minecraftBackup-nix.nix
  /nixos/other/lapisLazuli/nfs-nix.nix
  /nixos/data/hosts/bort/hardware-configuration.nix
]
