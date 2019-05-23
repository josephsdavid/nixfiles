{ config, pkgs, ... }:
{

  nixpkgs.config={
    allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };

};
  home= {
    packages =with pkgs; [
      google-chrome
      cachix
      mpv
      xorg.xdpyinfo
      (import ./vim.nix)
      tree
      maim
      slop
      xclip
      (import (fetchGit "https://github.com/haslersn/fish-nix-shell"))
      shellcheck
      haskellPackages.ghc 
      haskellPackages.cabal-install
      libreoffice
      obs-studio
      htop
      slop
      xdotool
      #allegro5
      #gnutls
      w3m
      wmctrl
      xsv
      fff
      firefox
      qutebrowser
      hexchat
      xclip
      calcurse
      signal-desktop
      slack
      ffmpeg
      playerctl
      lemonbar-xft
      zoom-us
      dmenu
      bc
      spotify
      libnotify
      chromium
      #google-chrome
      unzip
      p7zip
      encryptr
      scid-vs-pc
      stockfish
      evince

#      texlive.combined.scheme-full
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
  redshift = {
    enable = true;
    latitude = "32.776665";
    longitude = "-96.796989";
    brightness = {
      day = "1";
      night = "0.8";
    };
  #  temperature = {
   #   day = 6500;
    #  night = 5000;
   # };
  };

  dunst = {
    enable = true;

    settings = {
      global = {
        browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
        follow = "keyboard";
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
        foreground = "#000000";
        frame_color = "#5a7493";
        timeout = 5;
      };

      urgency_normal = {
        background = "#d5d3c7";
        foreground = "#000000";
        frame_color = "#5a7493";
        timeout = 15;
      };

      urgency_critical = {
        background = "#d5d3c7";
        foreground = "#000000";
        frame_color = "#5a7493";
        timeout = 0;
      };

      shortcuts = {
        history = "ctrl+grave";
        close = "ctrl+space";
      };
    };


#      scripts = [''
#          [music]
#          appname = "Spotify";
#          summary = "Now playing";
#          urgency = "critical";
#        ''];
    };

  };
  xdg.configFile."nixpkgs/config.nix".text = ''builtins.fromJSON '''${builtins.toJSON {

    allowUnfree = true;

  }}''''' ;

}
