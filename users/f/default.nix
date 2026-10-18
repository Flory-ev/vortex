{
  home.stateVersion = "26.05";

  my = {
    shell.enable = true;
    git = {
      enable = true;
      name = "F";
      email = "tkachuk@tuta.com";
    };
    ssh = {
      enable = true;
      bitwardenAgent.enable = true;
    };
    editor.zed = {
      enable = true;
      extensions = [ "nix" ];
    };
    apps = {
      communication = true;
      security = true;
      media = true;
      utilities = true;
    };
  };

  programs.firefox.enable = true;
}
