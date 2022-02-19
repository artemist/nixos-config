{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.default.settings = {
      "app.shield.outputstudies.enabled" = false;
      "privacy.firstparty.isolate" = true;
      "devtools.theme" = "light";
      "browser.urlbar.switchTabs.adoptIntoActiveWindow" = true;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    };
  };
}
