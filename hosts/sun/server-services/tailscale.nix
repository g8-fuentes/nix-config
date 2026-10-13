{ pkgs, lib, ... }: {

  services.tailscale = {
    enable = lib.mkDefault true;
    package = lib.mkDefault pkgs.tailscale;
    openFirewall = true;
    useRoutingFeatures = lib.mkDefault "server";
  };

}
