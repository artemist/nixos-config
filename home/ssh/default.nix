{ config, pkgs, ... }:

{
  # Make sure controlPath directory exists
  home.file.".ssh/c/.dummy".text = "";
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPersist = "10m";
    controlPath = "~/.ssh/c/%r@%n:%p";
    # We have to do this as text to gaurantee it's part of the last Host * block
    userKnownHostsFile = "~/.ssh/known_hosts ${./extra_known_hosts}";
    extraConfig = ''
      KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
      MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      VerifyHostKeyDNS ask
      VisualHostKey yes
      UpdateHostKeys ask
    '';

    # Most hosts are set in private
    matchBlocks = {
      "*.cmu.edu" = {
        user = "atosini";
        extraOptions = {
          GSSAPIAuthentication = "yes";
          GSSAPIDelegateCredentials = "yes";
        };
      };
      "github.com".extraOptions.ControlMaster = "no";
    };
  };
}
