{ pkgs, pkgs-unstable, ... }:

# based on https://alexbakker.me/post/nixos-pci-passthrough-qemu-vfio.html
{
  environment.systemPackages = [
    pkgs-unstable.looking-glass-client
    pkgs.scream
  ];

  boot.initrd = {
    availableKernelModules = [ "amdgpu" "vfio-pci" ];
    preDeviceCommands = ''
      echo vfio-pci > /sys/bus/pci/devices/0000:0b:00.0/driver_override
      echo vfio-pci > /sys/bus/pci/devices/0000:0b:00.1/driver_override
      modprobe -i vfio-pci
    '';
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/scream 0660 artemis qemu-libvirtd -"
    "f /dev/shm/looking-glass 0660 artemis qemu-libvirtd -"
  ];

  systemd.user.services.scream-ivshmem = {
    enable = true;
    description = "Scream IVSHMEM";
    serviceConfig = {
      ExecStart = "${pkgs.scream}/bin/scream -m /dev/shm/scream -o pulse";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
    requires = [ "pulseaudio.service" ];
  };
}
