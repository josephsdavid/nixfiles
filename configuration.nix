# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#let
#  scientifica = (import <nixpkgs> {}).callPackage ./scifi.nix {};
#in
#
#
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./direnv.nix
    ./services.nix
    ];

boot = {
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  kernelModules = [ 
    "coretemp"
    "kvm-intel"
    "modprobe"
    "nvidia_uvm"
  ];
  kernelPackages = pkgs.linuxPackages_latest;
#  kernelPackages = pkgs.linuxPackages_4_19;
};
virtualisation.docker = {
  enable = true;
};
  networking = {
    hostName = "nixon";
    networkmanager.enable = true;
  };
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix = {
    buildCores = 0;
    maxJobs = 12;
    gc = {
      automatic = true;
      dates = "07:15";
      options = "--delete-older-than 30d";
    };
  };

  # Set your time zone.
   time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
  environment.systemPackages = with pkgs; [
    gnome3.gnome-bluetooth
    cachix
    capitaine-cursors
    light
    spotify
    wget 
    mojave-gtk-theme
    nordic
    nordic-polar
    sierra-gtk-theme
    gnome3.gnome-tweaks
    adementary-theme
    ant-theme
    arc-icon-theme
    arc-theme
    clearlooks-phenix
    e17gtk
    elementary-xfce-icon-theme
    equilux-theme
    greybird
    numix-icon-theme
    numix-icon-theme-circle
    onestepback
    pantheon.elementary-gtk-theme
    pantheon.elementary-icon-theme
    pantheon.elementary-sound-theme
    cawbird
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.window-corner-preview
    gnomeExtensions.timepp
    theme-vertex
    zuki-themes
    gnome-themes-extra
    gnome3.gnome-backgrounds
    gnome3.gnome-calculator
    gnome3.gnome-weather
    gnomecast
    materia-theme
    planner
    stilo-themes
    gnome3.gnome-shell
    gnome3.gnome-shell-extensions
    gnome3.gnome-software
    gnome3.dconf-editor
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dash-to-dock
    deepin.deepin-icon-theme
    deepin.deepin-sound-theme
    pantheon.elementary-sound-theme
    faba-icon-theme
    maia-icon-theme
    material-design-icons
    material-icons
    nixos-icons
    paper-icon-theme
    lxappearance
    killall
    termite
    ranger 
    vim
    gcc
    pandoc
    neofetch 
    git 
    herbstluftwm 
    compton 
    dzen2 
    feh 
    arandr
    acpi
    tmux
    imagemagick
    lm_sensors
    cacert
    vlc
#(let src = builtins.fetchGit "https://github.com/target/lorri"; in import src { inherit src pkgs; })
   ];

   fonts.fonts = with pkgs; [
     iosevka
     nerdfonts
     tamsyn
     tewi-font
     ucs-fonts
     spleen
     fira
     cabin
     siji
     noto-fonts-cjk
     noto-fonts-emoji
     liberation_ttf
     cooper-hewitt
     manrope
     quattrocento
     quattrocento-sans
     fira-code
     fira-code-symbols
     mplus-outline-fonts
     proggyfonts
     cherry
     comfortaa
     dejavu_fonts
     envypn-font
     fantasque-sans-mono
     luculent
     meslo-lg
     montserrat
     noto-fonts
     open-sans
     lemon
	];
# Now let us configure our packages!
#
  nixpkgs.config = {
    allowUnfree = true;
    oraclejdk.accept_license = true;
    firefox = {
     enableAdobeFlash = true;
  };
   packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.dconf.enable = true;
  # List services that you want to enable:
  powerManagement.cpuFreqGovernor = "performance";

  # Enable CUPS to print documents.
 #  services.printing.enable = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio ={
    enable = true;
    support32Bit = true;
    extraModules = [pkgs.pulseaudio-modules-bt];
  };

  hardware.bluetooth = {
    enable = true;

    extraConfig = ''
    [General]
    ControllerMode = bredr
    '';


    package = pkgs.bluezFull;
  
    #powerOnBoot = false;
  };

  # hardware services
  hardware.cpu.intel.updateMicrocode = true;

# attempt at OPTIMUS
#hardware.bumblebee.enable = true;
#  # install nvidia drivers in addition to intel one
#  # disable card with bbswitch by default since we turn it on only on demand!
#  # its CUDA time
#   hardware.nvidiaOptimus.disable = true;
#  # install nvidia drivers in addition to intel one
#   hardware.opengl.driSupport32Bit = true;
#   hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
#   hardware.opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];



# Some bash programs
programs.bash = {
  enableCompletion = true;
};
programs.fish.enable=true;
programs.vim.defaultEditor = true;
users.users.david = {
	isNormalUser=true;
	home = "/home/david";
	description = "David Josephs";
        extraGroups = [ "wheel" "power" "networkmanager" "audio" "docker" "flatpak"];
        shell = "/run/current-system/sw/bin/fish";
      };


      

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
