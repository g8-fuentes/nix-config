{ pkgs, ... }: {
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
  environment.systemPackages = with pkgs;
    [
      ntfs3g
    ];

}
