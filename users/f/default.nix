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
      archive = true;
      communication = true;
      security = true;
      media = true;
      utilities = true;
      windows = true;
    };
  };

  # Plain home-manager options still work alongside the `my.*` ones.
  programs.firefox.enable = true;
}
