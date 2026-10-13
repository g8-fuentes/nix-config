{ ... }:
{

  virtualisation.oci-containers.containers.flatnotes = {
    hostname = "flatenotes";
    image = "dullage/flatnotes:latest";
    ports = [ "127.0.0.1:9106:8080" ];
    volumes = [ "/var/lib/storage/flatnotes:/data" ];
    environment = {
      FLATNOTES_AUTH_TYPE = "none";
    };
  };
  virtualisation.oci-containers.containers.excalidraw = {
    hostname = "excalidraw";
    image = "excalidraw/excalidraw";
    ports = [ "127.0.0.1:9113:80" ];
  };

  virtualisation.oci-containers.containers.convertx = {
    hostname = "convertx";
    image = "c4illin/convertx";
    ports = [ "127.0.0.1:9107:3000" ];
  };
  virtualisation.oci-containers.containers.metube = {
    hostname = "metube";
    image = "alexta69/metube:2026.03.21";
    ports = [ "127.0.0.1:9108:8081" ];
    volumes = [
      "/var/lib/storage/nextcloud/data/guifuentes8@gmail.com/files/Youtube:/downloads"
    ];
  };

}
