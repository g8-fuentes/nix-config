{ ... }: {
  services = {
    playerctld.enable = true;
    mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }
      '';
    };
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
