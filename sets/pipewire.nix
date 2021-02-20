{ pkgs, lib, ... }:

{
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = pkgs.targetPlatform.system == "x86_64-linux";
    };
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = lib.mkForce false;
  environment.systemPackages = with pkgs; [
    pulseaudioLight
    qjackctl

    carla
    lsp-plugins
  ];
}
