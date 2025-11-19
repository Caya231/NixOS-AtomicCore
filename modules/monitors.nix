{ config, pkgs, ... }:

{
  # Script que roda no login
  systemd.user.services.xrandr-monitors = {
    description = "Configure monitors with xrandr";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --primary --mode 1920x1080 --rate 180 --pos 1366x0 --output DVI-D-1 --mode 1366x768 --rate 59.86 --pos 0x0'";
      RemainAfterExit = true;
    };
  };
}
