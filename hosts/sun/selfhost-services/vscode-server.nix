{ pkgs, ... }: {
  services.openvscode-server = {
    enable = true;
    package = pkgs.openvscode-server;
    port = 9111;
    user = "g8";
    group = "root";
    host = "0.0.0.0";
    withoutConnectionToken = true;
    telemetryLevel = "off";
  };
}
