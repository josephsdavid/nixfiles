# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



#
#
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
boot.kernelModules = [ "coretemp" "kvm-intel" "modprobe" ];
# Kernel options
# quick fix for nixos 19.03
boot.kernelPackages = pkgs.linuxPackages_4_19;
#boot.kernelPackages = pkgs.linuxPackages_latest;
   networking.hostName = "nixon"; # Define your hostname.
 #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

#Let there be music!!
#
#
#other packages
# other x things
#
  nix = {
    buildCores = 0;
    gc = {
      automatic = true;
      dates = "06:15";
      options = "--delete-older-than 30d";
    };
  };
services.xserver.enable = true;
services.xserver.windowManager.herbstluftwm.enable = true;
#services.xserver.desktopManager.xfce.enable = true;
services.xserver.videoDrivers = [ "nvidia" ];
services.xserver.libinput.enable = true;
#services.compton = {
#	enable = true;
#	fade = false;
#	inactiveOpacity = "1.0";
#	shadow = false;
#};
  # Set your time zone.
   time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget 
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
        vlc
   ];
fonts.fonts = with pkgs; [
  nerdfonts
  iosevka
  ttf-envy-code-r
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
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
    firefox = {
    # enableAdobeFlash = true;
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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
#services.tlp.enable = true;
services.upower.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
   services.printing.enable = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware services
   hardware.cpu.intel.updateMicrocode = true;
 # disable card with bbswitch by default since we turn it on only on demand!
 # hardware.nvidiaOptimus.disable = true;
  # install nvidia drivers in addition to intel one
 # hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
 # hardware.opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];


# Some bash programs
  programs.bash.enableCompletion = true;
  programs.fish.enable=true;
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
   #services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
users.users.david = {
	isNormalUser=true;
	home = "/home/david";
	description = "David Josephs";
        extraGroups = [ "wheel" "power" "networkmanager" "audio"];
        shell = "/run/current-system/sw/bin/fish";
};
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
