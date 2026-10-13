{ pkgs, config, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.enable32Bit = true;
  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    mesa
  ];
}
