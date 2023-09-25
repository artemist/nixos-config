{ ... }:

{
  nix = {
    buildMachines = [{
      hostName = "starlight.manehattan.artem.ist";
      sshUser = "build";
      supportedFeatures = [ "kvm" "big-parallel" "benchmark" "nixos-text" ];
      system = "x86_64-linux";
      maxJobs = 2;
    }];
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  home-manager.users.root.programs.ssh = {
    enable = true;
    userKnownHostsFile = "~/.ssh/known_hosts ${../home/ssh/extra_known_hosts}";
  };
}
