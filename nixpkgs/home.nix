{ config, pkgs, ... }:
let 
  custom_config = builtins.readFile ./nvimrc;


  customPlugins =  with pkgs; {

    split-term = vimUtils.buildVimPlugin {
      name = "split-term";
      src = fetchgit {
        url= "https://github.com/vimlab/split-term.vim";
 sha256 ="12vrmbq1r8d6sgyxjwi0s856n1v4vjhrf8wpwq6l4ydmk1bnvjkb";
   };
 };


 pmode = vimUtils.buildVimPlugin {
   name = "python-mode";
   src = fetchgit {
     url= "https://github.com/python-mode/python-mode";
 sha256 ="0a3fp6bh6i555g5a6hjbn1y5xanl3xqmkid0qp31b258f07ssqdh";
   };
   buildInputs = [
     python37 
     python37Packages.rope
     python37Packages.pylama
     python37Packages.mccabe
     python37Packages.pycodestyle
     python37Packages.pydocstyle
     python37Packages.pyflakes
     python37Packages.pylint
     python37Packages.snowballstemmer
   ];
 };
 nvim-r = vimUtils.buildVimPlugin {
   name = "nvim-r";
   src = fetchgit {
     url= "https://github.com/jalvesaq/nvim-r";
 sha256 = "15cajp6c4123mxcy8km0bzdpjl4q50h1wq9ah69x174s112c86ni";
   };
   buildInputs = [ which vim  zip];
 };
 vim-pandoc-syntax = vimUtils.buildVimPlugin {
   name = "vim-pandoc-syntax";
   src = fetchgit {
     url = "https://github.com/vim-pandoc/vim-pandoc-syntax";
     sha256 ="04hmcqag21fmb3flabbhybp6s8ysf3rxr05kxqdlln4wamimag81";
   };
 };

 synthvim = vimUtils.buildVimPlugin {
   name = "synthvim";
   src = fetchgit {
     url ="https://github.com/artanikin/vim-synthwave84";
     sha256 ="0vp1z7slim12v3zpaasxnz7kn2isplbng5rhh15binb513jlzhn1";
   };
 };
 
 gitvim = vimUtils.buildVimPlugin {
   name = "gitvim";
   src = fetchgit {
     url = "https://github.com/cormacrelf/vim-colors-github";
     sha256 ="1nnbyl6qm7rksz4sc0cs5hgpa9sw5mlan732bnn7vn296qm9sjv1";
   };
 };

 lightline = vimUtils.buildVimPlugin {
   name = "lightline";
   src = fetchgit {
     url = "https://github.com/itchyny/lightline.vim";
     sha256 ="0qrz4nwb4imnxiqk3p1r4sxib1gjicpsr3g6l8mdgw806l1jc9mg";
   };
 };

 vim-processing =  vimUtils.buildVimPlugin {
   name = "vim-processing";
   src = fetchgit {
     url = "https://github.com/sophacles/vim-processing";
     sha256 = "1irnpc08wlwwbbi48glv31s35dgn7329cqnhap66m9byqzsqyz2y";
   };
 };
};

      in
      {
        nixpkgs.config={
          oraclejdk.accept_license = true;
          allowUnfree = true;
          packageOverrides = pkgs: {
            nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
              inherit pkgs;
            };
          };

        };

  #  imports = [
  #    ./nvim.nix
  #  ];
  home= {
    packages =with pkgs; [
      ncat
      weechat
      jre
      jdk
      skypeforlinux
      vscode
      networkmanager_dmenu
      aws
      python37Packages.ipython
      python37Packages.jupyterlab
      cpufrequtils
      xsel
      #processing
      gcc
      cmake
      pango
      gnumake
      texlive.combined.scheme-full
      usbutils
      stack
      mpv
      xorg.xdpyinfo
      (import ./vim.nix)
      tree
      maim
      slop
      xclip
      (import (fetchGit "https://github.com/haslersn/fish-nix-shell"))
      shellcheck
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
      libnotify
      chromium
      google-chrome
      unzip
      p7zip
      encryptr
      scid-vs-pc
      stockfish
      evince
      go
      git-lfs
      higan

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
  neovim = {
    enable = true;
    vimAlias = false;
    viAlias = true;
    extraConfig = custom_config;
    plugins = with pkgs.vimPlugins // customPlugins; [
      repeat
      split-term
      vim-slime
      auto-pairs
      Syntastic
      vim-nix
      vim-tmux-navigator
      surround
      vim-markdown
      vim-fugitive
      vimtex
      vim2hs
      vim-processing
      ctrlp
      pmode
      syntastic
      nvim-r
      vim-diminactive
      vim-scala
      papercolor-theme
      vim-pandoc-syntax
      lightline
      gitvim
      synthvim
    ];
  };


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
        night = "0.7";
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
     music = {
       appname = "Spotify";
       summary = "Now playing";
       urgency =  "low";
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
    oraclejdk.accept_license = true;

  }}''''' ;

}
