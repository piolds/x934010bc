{pkgs, inputs, ... }: {
  imports = with inputs; [
      ./common/zsh
  ];

  home.stateVersion = "23.11";
}
