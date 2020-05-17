{ config, pkgs, ... }:

{
  security.tpm2 = {
    enable = true;
    applyUdevRules = true;
    abrmd.enable = true;
    pkcs11.enable = true;
    tctiEnvironment = {
      enable = true;
      interface = "tabrmd";
    };
  };
}
