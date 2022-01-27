{ pkgs, ... }:

{
  boot.kernelPatches = [{
    name = "fix-execve";
    patch = pkgs.fetchpatch
      {
        url = "https://git.alpinelinux.org/aports/plain/main/linux-lts/0001-fs-exec-require-argv-0-presence-in-do_execveat_commo.patch?id=520e6dfd6e814414ab7cf862b897ca6ba427d30f";
        sha256 = "sha256-vrN64lGDiAFgMn5SGWiI9MwNRct4m9DJDxokFZ6EpiE=";
      };
  }];
}
