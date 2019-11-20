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
    #./cachix.nix
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
virtualisation.docker.enable = true;
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
    spotify
    wget 
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

  # List services that you want to enable:
  powerManagement.cpuFreqGovernor = "performance";

  # Enable CUPS to print documents.
 #  services.printing.enable = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio ={
    enable = true;
    support32Bit = true;
  };

  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
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
        extraGroups = [ "wheel" "power" "networkmanager" "audio" "docker"];
        shell = "/run/current-system/sw/bin/fish";
      };


      

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
