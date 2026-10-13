{
  config,
  lib,
  options,
  pkgs,
  ...
}:
let
  isDarwin = options ? launchd;
  username = if isDarwin then "administrador" else "g8-fuentes";
in
{
  imports = [ ../core ];

  config = lib.mkMerge [
    {
      nix.settings.trusted-users = [ username ];
    }

    (lib.optionalAttrs (!isDarwin) {
      users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [
          "networkmanager"
          "wheel"
          "sudo"
          "video"
          "docker"
          "podman"
          "adbusers"
          "input"
          "vboxusers"
          "nextcloud"
          "vaultwarden"
          "storage"
          "libvirtd"
          "cloudflared"
          "media"
          "writefreely"
          "caddy"
          "tailscale"
        ];
        shell = pkgs.zsh;
      };

      sops = {
        defaultSopsFile = ../../secrets/common.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "${config.users.users.${username}.home}/.config/sops/age/keys.txt";
        age.generateKey = true;
        age.sshKeyPaths = [ ];
        secrets = {
          github-token = { };
        };
      };

      programs = {
        dconf.enable = true;
        git.enable = true;
        partition-manager.enable = true;
        nh = {
          enable = true;
          clean.enable = true;
          flake = "${config.users.users.${username}.home}/nix-config";
        };
      };

      services = {
        tailscale.enable = true;
        tailscale.package = pkgs.tailscale;
        tailscale.openFirewall = true;
        tailscale.useRoutingFeatures = "client";
        dbus = {
          enable = true;
          packages = [ pkgs.gcr ];
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
        pulseaudio.enable = false;
      };

      environment = {
        systemPackages = with pkgs; [ sops ];
        sessionVariables = {
          XDG_CACHE_HOME = "\${HOME}/.cache";
          XDG_CONFIG_HOME = "\${HOME}/.config";
          XDG_BIN_HOME = "\${HOME}/.local/bin";
          XDG_DATA_HOME = "\${HOME}/.local/share";
          TZ = "America/Sao_Paulo";
        };
        pathsToLink = [
          "/libexec"
          "/etc"
        ];
      };

      networking = {
        networkmanager.enable = true;
        firewall = rec {
          enable = true;
          allowedTCPPorts = [
            80
            443
          ];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedUDPPortRanges = allowedTCPPortRanges;
        };
      };

      security.rtkit.enable = true;
      security.polkit.enable = true;

      i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = lib.mkDefault "pt_BR.utf8";
          LC_IDENTIFICATION = lib.mkDefault "pt_BR.utf8";
          LC_MEASUREMENT = lib.mkDefault "pt_BR.utf8";
          LC_MONETARY = lib.mkDefault "pt_BR.utf8";
          LC_NAME = lib.mkDefault "pt_BR.utf8";
          LC_NUMERIC = lib.mkDefault "pt_BR.utf8";
          LC_PAPER = lib.mkDefault "pt_BR.utf8";
          LC_TELEPHONE = lib.mkDefault "pt_BR.utf8";
          LC_TIME = lib.mkDefault "pt_BR.UTF-8";
        };
        supportedLocales = lib.mkDefault [
          "en_US.UTF-8/UTF-8"
          "pt_BR.UTF-8/UTF-8"
        ];
      };

      nix.settings.auto-optimise-store = lib.mkDefault true;
      nixpkgs.hostPlatform = "x86_64-linux";

      powerManagement.cpuFreqGovernor = lib.mkForce "performance";
      time.hardwareClockInLocalTime = true;
      boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';

      system.stateVersion = "26.05";
    })

    (lib.optionalAttrs isDarwin {
      users.users.${username}.home = "/Users/${username}";

      system.primaryUser = username;
      system.stateVersion = 6;
      nixpkgs.hostPlatform.system = "aarch64-darwin";

      nix = {
        linux-builder.enable = false;
        gc.automatic = true;
        extraOptions = ''
          extra-platforms = x86_64-linux x86_64-darwin aarch64-darwin
          ssl-cert-file = /etc/nix/ca_cert.pem
        '';
      };
      security.pki.installCACerts = true;

      launchd.daemons.nix-daemon.environment = {
        NIX_SSL_CERT_FILE = "/etc/nix/ca_cert.pem";
        SSL_CERT_FILE = "/etc/nix/ca_cert.pem";
        REQUEST_CA_BUNDLE = "/etc/nix/ca_cert.pem";
      };

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
        };
        casks = [
          "bitwarden"
          "caffeine"
          "microsoft-teams"
          "pika"
          "obs"
        ];
      };
    })
  ];
}
