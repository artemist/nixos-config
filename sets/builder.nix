{ ... }:

{
  nix.settings.trusted-users = [ "build" ];
  users.users.build = {
    isSystemUser = true;
    home = "/home/build";
    createHome = true;
    useDefaultShell = true;
    group = "build";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOBdARV3DVx4fKTf1hCSmOz+S06pI28cvrdo+FbWDP/ root@rainbowdash"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINU/XVVEM3lATgDbjk2JvJ0HIkkELkldMFk5QrejgXsI root@spike"
    ];
  };
  users.groups.build = { };
}
