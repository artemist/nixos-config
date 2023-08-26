{ config, ... }:

{
  nix = {
    buildMachines = [{
      hostName = "starlight";
      supportedFeatures = [ "kvm" "big-parallel" "benchmark" "nixos-text" ];
      system = "x86_64-linux";
      maxJobs = 2;
    }];
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
