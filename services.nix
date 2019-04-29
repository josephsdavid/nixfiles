{ config, pkgs, ... }:
{
services = {
  openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  printing = {
    enable = true;
  };

  upower = {
    enable = true;
  };

  # DAtabases
#  neo4j = {
#    enable = true;
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
  

  xserver = {
    enable = true;

    windowManager = {
      herbstluftwm.enable = true;
    };


    videoDrivers = [ "nvidia" ];
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
