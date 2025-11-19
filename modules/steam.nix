{ config, lib, pkgs, ... }:

{
  # Habilitar suporte a programas não-livres
  nixpkgs.config.allowUnfree = true;

  # Configuração da Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Suporte a 32-bit para gráficos e áudio
  hardware.graphics.enable32Bit = true;
  
  # Configuração de áudio - PipeWire (descomente PulseAudio se preferir)
  
  # Opção 1: PipeWire (recomendado)
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Opção 2: PulseAudio (comente o bloco PipeWire acima e descomente abaixo)
  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };

  # Pacotes úteis para gaming
  environment.systemPackages = with pkgs; [
    steam-run
    protonup-qt
    gamescope
    mangohud
  ];
}
