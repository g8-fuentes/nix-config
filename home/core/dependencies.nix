{ pkgs, lib, ... }:
{
  home.packages =
    with pkgs;
    lib.mkIf (pkgs.stdenv.hostPlatform.isLinux) [
      appimage-run
      ffmpeg
      pciutils
      mesa-demos
      pulseaudio
      unzip
      chafa
      lshw
      imagemagick
      ffmpegthumbnailer
      poppler-utils
      xdotool
      playerctl
      xprop
      cacert
      wget
      usbutils

    ];
}
