{ config, ... }:
{
  networking = {
    hostName = "sun";
    defaultGateway = "192.168.1.1";
    interfaces.wlp0s20u11 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.1.10";
          prefixLength = 24;
        }
      ];
    };
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [
        80
        443
        8082
        config.services.tailscale.port
      ];
      allowedTCPPorts = [
        80
        443
        8082
        config.services.tailscale.port
      ];
    };
  };

}
