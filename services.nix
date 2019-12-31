{ config, pkgs, ... }:
{
  networking.dhcpcd.enable = true;
  services = {
    dbus = {
      packages = [pkgs.gnome3.dconf];
    };
    #emacs = {
     # enable = true;
   # };
   openssh = {
     enable = true;
     permitRootLogin = "no";
   };

   flatpak = {
     enable = true;
   };

   printing = {
     enable = true;
   };

   upower = {
     enable = true;
   };

  # DAtabases
#  neo4j = {
#   enable = true;
#    package = pkgs.neo4j;
#  };

#  mysql = {
#    enable = true;
#    package = pkgs.mysql;
#  };

#  mongodb = {
#    enable = true;
#    package = pkgs.mongodb;
#  };


udev.extraRules =
  ''
  KERNEL=="nvidia", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidiactl c $(grep nvidia-frontend /proc/devices | cut -d \  -f 1) 255'"
  KERNEL=="nvidia_modeset", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidia-modeset c $(grep nvidia-frontend /proc/devices | cut -d \  -f 1) 254'"
  KERNEL=="card*", SUBSYSTEM=="drm", DRIVERS=="nvidia", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidia%n c $(grep nvidia-frontend /proc/devices | cut -d \  -f 1) %n'"
  KERNEL=="nvidia_uvm", RUN+="${pkgs.runtimeShell} -c 'mknod -m 666 /dev/nvidia-uvm c $(grep nvidia-uvm /proc/devices | cut -d \  -f 1) 0'"
  '';
  xserver = {
  enable = true;

  windowManager = {
    herbstluftwm.enable = true;
    fvwm = {
      enable = true;
      gestures = true;
    };
  };

  desktopManager = {
    #  dde.enable =true;
      gnome3.enable = true;
};



     videoDrivers = [ "nvidia" ];

     #videoDrivers = [ "intel" ];
    libinput = {
    enable = true;
    naturalScrolling = false;
    };
    };

    compton = {
    enable = true;
    fade = false;
    inactiveOpacity = "1.0";
    shadow = false;
    };

    };
    }
