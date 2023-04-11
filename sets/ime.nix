{ pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };
  environment.systemPackages = with pkgs; [ fcitx5-configtool ];

  # Required for support in kitty, ibus/fcitx5 are somewhat compatible so this works
  environment.variables.GLFW_IM_MODULE = "ibus";

  home-manager.users.artemis.wayland.windowManager.sway.config.startup = [
    { command = "fcitx5 -d --replace"; always = true; }
  ];
}
