{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot-config.nix
    ./secure-boot.nix
    ./hardware-configuration.nix
    ../../sets/buildMachines.nix
    ../../sets/hardware.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/ime.nix
    ../../sets/1password.nix
    ../../sets/virtualization.nix
    ../../sets/workstation.nix
    ../../sets/krb5.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
  ];

  boot.supportedFilesystems = [ "nfs4" ];

  # Home
  home-manager.users.artemis = {
    wayland.windowManager.sway.config = {
      output."eDP-1" = { mode = "3840x2400@59.994Hz"; scale = "2"; };
      input."1386:18753:Wacom_HID_4941_Finger".map_to_output = "eDP-1";
      input."1739:52710:DLL096D:01_06CB:CDE6_Touchpad" = { middle_emulation = "enabled"; click_method = "clickfinger"; };
      startup = [{ command = "swayidle -w before-sleep 'light -O' after-resume 'light -I'"; always = true; }];
    };
    xdg.configFile."rustybar/config.toml".text = ''
      [[tile]]
      type = "load"
      [[tile]]
      type = "memory"
      [[tile]]
      type = "hostname"
      [[tile]]
      type = "battery"
      [[tile]]
      type = "time"
      format = "%Y-%m-%dT%H:%M:%S"
    '';
  };

  # Not in nixos-hardware for some reason
  hardware.opengl.extraPackages = with pkgs; [
    intel-compute-runtime
  ];

  boot.blacklistedKernelModules = [ "psmouse" ];
  services.thermald.enable = true;

  networking.domain = "manehattan.artem.ist";
  networking.hostName = "rainbowdash";
  system.stateVersion = "20.03";
}
