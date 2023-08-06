{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pipewire.jack

    carla
    lsp-plugins
  ];
}
