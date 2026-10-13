{ pkgs, lib, ... }:

{
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    port = 11434;
    package = pkgs.ollama-cpu;
    loadModels = [
      "deepseek-coder-v2:16b"
    ];
    syncModels = true;
    environmentVariables = {
      OMP_NUM_THREADS = "24";
      OLLAMA_MAX_LOADED_MODELS = "1";
      OLLAMA_KEEP_ALIVE = "-1";
      OLLAMA_CONTEXT_LENGTH = "8192";
      OLLAMA_BATCH_SIZE = "512";
      OLLAMA_NUM_PARALLEL = "1";
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";

    };
  };

  systemd.services.ollama.serviceConfig.ExecStart =
    lib.mkForce "${pkgs.numactl}/bin/numactl --cpunodebind=1 --membind=1 ${pkgs.ollama-cpu}/bin/ollama serve";

  environment.systemPackages = [
    pkgs.numactl
    pkgs.ollama
  ];
}
