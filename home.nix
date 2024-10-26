{pkgs, inputs, ... }: {
  imports = with inputs; [
      ./common/zsh
  ];
}
