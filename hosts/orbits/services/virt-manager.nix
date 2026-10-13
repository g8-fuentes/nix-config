{ ... }: {
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "br0" ];
  };
  networking.defaultGateway = "192.168.0.1";
  networking.useDHCP = false;
  networking.bridges.br0.interfaces = [ "enp4s0" ];
  networking.interfaces.br0 = { useDHCP = true; };
  networking = { firewall.trustedInterfaces = [ "br0" ]; };
  boot.extraModprobeConfig = "options kvm_intel nested=1";

}

