{ config, pkgs, ... }:

{

  nixpkgs.config={
    allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };

#  firefox = {
 #   enableAdobeFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
  #:};
};
  home= {
    packages =with pkgs; [
      (import ./vim.nix)
      htop
      firefox-devedition-bin
      hexchat
      R
      rPackages.knitr
      rPackages.rmarkdown
      calcurse
      signal-desktop
      slack
      ffmpeg
      lemonbar-xft
      zoom-us
      dmenu
      bc
      spotify
      libnotify
      google-chrome
      unzip
      encryptr
#pkgs.rstudio
  ];
};

programs = {
  git = {
    enable=true;
    userName = "josephsdavid";
    userEmail = "josephsd@smu.edu";
  };
  zathura = {
    enable = true; 
  };


#bash = {
#      enable = false;
#      enableAutojump = true;
#      historyControl = [ "erasedups" "ignorespace" ];
#      historyFile = "\$HOME/.cache/bash_history";
#      shellAliases = {
#        def-build = "nix-build -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
#        def-shell = "nix-shell -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
#        e = "exa";
#        eal = "exa -al";
#        el = "exa -l";
#        em = "emacs";
#        htop = "htop -t";
#        mkdir = "mkdir -p";
#        ra = "ranger";
#        v = "vim";
#        g =  "git";
#        ga = "git add";
#        gc = "git commit -m";
#        gp = "git push";
#        gco = "git checkout";
#        
#        hc = "herbstclient";
#      };
#      shellOptions = [
#        "cdspell"
#        "checkjobs"
#        "extglob"
#        "globstar"
#        "histappend"
#        "nocaseglob"
#      ];
#    };
    fzf = {
      enable = true;
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  services = {
  dunst = {
    enable = true;
    settings = {
      global = {
        browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
        follow = "mouse";
        font = "Iosevka 12";
        format = "<b>%s</b>\\n%b";
        frame_color = "#555555";
        frame_width = 2;
        geometry = "500x5-5+50";
        horizontal_padding = 8;
        icon_position = "off";
        line_height = 0;
        markup = "full";
        padding = 8;
        separator_color = "frame";
        separator_height = 2;
        transparency = 0;
        word_wrap = true;
      };

      urgency_low = {
        background = "#d5d3c7";
        foreground = "#202421";
        frame_color = "#202421";
        timeout = 5;
      };

      urgency_normal = {
        background = "#d5d3c7";
        foreground = "#70a040";
        frame_color = "#70a040";
        timeout = 15;
      };

      urgency_critical = {
        background = "#d5d3c7";
        foreground = "#dd5633";
        frame_color = "#dd5633";
        timeout = 0;
      };

      shortcuts = {
        context = "control+grave";
        close = "control+space";
      };
};
    };
};
}
