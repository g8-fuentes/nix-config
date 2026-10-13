{ pkgs, ... }: {

  networking.networkmanager = {
    enableStrongSwan = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-vpnc
      networkmanager_strongswan
    ];
  };
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];

  services.strongswan.enable = true;
  services.pptpd.enable = true;
}
