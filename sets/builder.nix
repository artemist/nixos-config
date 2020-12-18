{ config, ... }:

{
  nix.trustedUsers = [ "build" ];
  users.users.build = {
    isNormalUser = false;
    home = "/home/build";
    createHome = true;
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOBdARV3DVx4fKTf1hCSmOz+S06pI28cvrdo+FbWDP/ root@rainbowdash"
    ];
  };
}
