{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "tjensen";
  
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
  
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;
  
  environment.systemPackages = with pkgs; [ python3 ];
  
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ 
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILruIcWP84RhI9XTvvSFd0HxEFvjv1tdUnv0eBn3J6VQ"
  ];

  system.stateVersion = "20.09"; # Did you read the comment?
}
