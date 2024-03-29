{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Artemis Tosini";
    userEmail = "me@artem.ist";
    signing = {
      key = "D2173817C3E4B155EA8FFF49A54531E0D32143ED";
      signByDefault = true;
    };
    ignores = [ "compile_commands.json" ".clangd/" ".idea/" ".config/clangd" ];
    lfs.enable = true;
    delta.enable = true;
    extraConfig = {
      transfer.fsckObjects = true;

      advice.detachedHead = false;
      pull.rebase = true;
      init.defaultBranch = "canon";
      log.showSignature = true;

      credential.helper =
        "!${pkgs.gitAndTools.pass-git-helper}/bin/pass-git-helper $@";
      sendemail = {
        smtpServer = "smtp.fastmail.com";
        smtpUser = "me@artem.ist";
        smtpEncryption = "tls";
        smtpServerPort = 587;
        confirm = "auto";
      };
    };
  };
}
