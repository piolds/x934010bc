{ pkgs, ...}: 
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      #cppenv="nix-shell $HOME/blueprints/configs/dotfiles/desktop/shells/cppenv.nix --command 'zsh'";
      #yacppenv="nix-shell $HOME/blueprints/configs/dotfiles/desktop/shells/yacppenv.nix --command 'zsh'";
      #clang-env="nix-shell $HOME/blueprints/configs/dotfiles/desktop/shells/yaclangenv.nix --command 'zsh'";
      ":q" = "exit";
      nvsp = "nvim .";
      t="todo sort; todo";
      cmake = "cmake-wrapper.sh";
      bmtui = "bluetuith";
      notifyme = "notify-send Done: $history[$((HISTCMD))]";
      tig="tig --ignore-submodules";
    };

  oh-my-zsh = {
    enable = true;
    extraConfig = (builtins.readFile ./zsh-config.sh);
  };

  plugins = [
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "932e29a0c75411cb618f02995b66c0a4a25699bc";
        sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
      };
    }
    {
      name = "zsh-autosuggestions";
	  src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
        sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
      };
    }
    {
      name = "formarks";
      src = pkgs.fetchFromGitHub {
        owner = "wfxr";
        repo = "formarks";
        rev = "b0d6c7cd5fdff87e4dbe64fcbc9d060dd780bb61";
        sha256 = "EbwIlpaMKLh8iIjxikrQ+vL6RgpXycyggpwyvR2WXK8=";
      };
    }
    {
      name = "zsh-autopair";
      src = pkgs.fetchFromGitHub {
        owner = "hlissner";
        repo = "zsh-autopair";
        rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
        sha256 = "PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
      };
    }
    {
      name = "zsh-vi-mode";
      src = pkgs.fetchFromGitHub {
        owner = "jeffreytse";
        repo = "zsh-vi-mode";
        rev = "1f28e1886dc8e49f41b817634d5c7695b6abb145";
        sha256 = "ylkZ4oVRxBJbk6tJ6UxkDjS+5eCr7efezuTrz8OZm+4=";
      };
    }
  ];
};
}
