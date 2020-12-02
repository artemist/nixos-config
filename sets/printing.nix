{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = [
      (pkgs.pkgsi686Linux.callPackage ../externals/packages/hll2300d { })
    ];
  };
}
