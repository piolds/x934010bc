# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let 
  dwm-overlay = (self: super: {
    dwm = super.dwm.overrideAttrs (prev: {
      version = "git";
      src = pkgs.fetchFromGitHub {
        owner = "6367f766";
        repo = "mdwm";
        rev = "main";
        sha256 = "qWJeXY6RK4T8khynZvk8ZNZNX+tB+GeKsxApa8TgV5I=";
      };
      postInstall = ''
        mkdir -p $out/share/xsessions/ 
        echo "[Desktop Entry]
        Encoding=UTF-8
        Name=dwm
        Comment=Dynamic window manager
        Exec=/home/asolomes/.nix-profile/bin/dwm
        Type=XSession
        " > $out/share/xsessions/dwm.desktop
        '';

    });
  });


  st-overlay = (self: super: {
    st = super.st.overrideAttrs (prev: {
      version = "git";
      src = pkgs.fetchFromGitHub {
        owner = "ALL-SPACE-XELA";
        repo = "st";
        rev = "master";
        sha256 = "ec37AiibtFWvstOh6kFo0Ztp9UAjypCeJKsA/AgGTEA=";
      };
    });
  });
in
{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable X11 
  services.xserver = {
    enable = true;
    layout = "gb";
    #displayManager.lightdm = {
    #  enable = true;
    #  greeters.mini = {
    #    enable = true;
    #    user = "user";
    #    extraConfig = ''
    #      [greeter-theme]
    #      backround=/home/user/blueprints/configs/dotfiles/desktop/system/user.png
    #      '';
    #  };
    #};
    windowManager.dwm.enable = true;
    libinput.enable = true;
  };

  services.xserver = {
    	desktopManager = {
    		cinnamon.enable = false;
    	};
    	displayManager.defaultSession = "none+dwm";
  };

  services.picom.enable = true;

  # remote desktop
  # services.xrdp.enable = true;
  # services.xrdp.openFirewall = true;
  # services.xrdp.defaultWindowManager = "dwm";

  nixpkgs.overlays = [
    dwm-overlay
    st-overlay
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # if wake-on-lan
  # networking.interfaces.enp34s0.wakeOnLan.enable = true;
  
  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

#  services.udev.extraRules = ''
#    # Your rule goes here
#    # Make FTDI device usable from users in group plugdev.
#SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", MODE="0664", GROUP="plugdev"
#
## Disallow ftdi_sio from loading.
#SUBSYSTEM=="usb", DRIVER=="ftdi_sio", ATTRS{idVendor}=="0403", RUN+="/bin/sh -c 'echo $kernel > /sys/bus/usb/drivers/ftdi_sio/unbind'"
#  '';

  #services.samba = {
  #  enable = true;
  #  securityType = "user";
  #  openFirewall = true;
  #  extraConfig = ''
  #    workgroup = WORKGROUP
  #    '';
  #  shares = {
  #    public  = {
  #      path = "/goprodump";
  #      browseable = "yes";
  #      writeable = "yes";
  #      "read only" = "no";
  #      "guest ok" = "yes";
  #      "create mask" = "0644";
  #      "directory mask" = "0770";
  #      "force user" = "user";
  #    };
  #  };
  #};

  #services.samba-wsdd = {
  #  enable = true;
  #  openFirewall = true;
  #};

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    group = "user";
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    vim
    git 
    wget 
    curl 
    gawk
    dwm
    dmenu
    st

    greetd.tuigreet

    dunst
    libnotify
    swww
    kitty # terminal emulator for now
    dolphin
    brave
    
    # music/sound
    pavucontrol
    pamixer
    playerctl

    # icon theme
    pkgs.gnome.adwaita-icon-theme

  ];

  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
  ];
  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };
  users.users."user".openssh.authorizedKeys.keys = [
  ];

  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  # networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 139 -j CT --helper netbios-ns'';


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
