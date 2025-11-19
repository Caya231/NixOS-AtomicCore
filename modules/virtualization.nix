# virtualization.nix
{ config, pkgs, ... }:

{
  # Habilita a virtualização com libvirt
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # Adiciona suporte a redes virtuais
  virtualisation.libvirtd.extraConfig = ''
    unix_sock_group = "libvirtd"
    unix_sock_rw_perms = "0770"
  '';

  # Instala o virt-manager e ferramentas relacionadas
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  # Adiciona o usuário ao grupo libvirtd
  # Substitua "seu-usuario" pelo seu nome de usuário
  users.users.cayazita = {
    extraGroups = [ "libvirtd" ];
  };

  # Habilita dnsmasq para as redes virtuais
  programs.dconf.enable = true;

  # Configurações adicionais opcionais para melhor desempenho
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  
  # Descomente a linha abaixo se você quiser iniciar o serviço automaticamente
  # systemd.services.libvirtd.wantedBy = [ "multi-user.target" ];
}

