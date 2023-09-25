{ ... }:

{
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
  };

  programs.gpg.enable = true;
}
