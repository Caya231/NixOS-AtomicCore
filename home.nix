# home.nix by Deive
{pkgs, config, ...}: {

# imports = [ ];

  home.username = "cayazita";
  home.homeDirectory = "/home/cayazita";

  home.packages = with pkgs; [ 

  ];

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  nixpkgs.config.allowUnfree = true;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";
}
