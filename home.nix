{ config, pkgs, nixpkgs, ... }:

{
  home.username = "aurameow";
  home.homeDirectory = "/home/aurameow";

  # Set cursor size and dpi for high-resolution displays
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 300;
  };

  # Cursor configuration
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Essential Packages 
home.packages = with pkgs; [

  # Core System & Utilities
  btop                              # Resource monitor
  fastfetch                         # System information display tool
  hyprutils                         # Utilities specific to the Hyprland compositor
  hyprlock                          # Screen locker for Hyprland
  wlogout                           # Logout manager for Wayland
  wl-clipboard                      # Command-line interface for Wayland clipboard
  libnotify                         # Library for desktop notifications
  brightnessctl                     # Tool to control display brightness
  playerctl                         # Command-line media player control
  grim                              # Tool for taking screenshots in Wayland
  slurp                             # Tool for selecting regions of the screen in Wayland (often used with `grim`)
  wf-recorder                       # Screen recorder for Wayland
  tree                              # Displays directory contents in a tree-like format
  pavucontrol                       # PulseAudio volume control application
  wireplumber                       # Session and policy manager for PipeWire
  mako                              # Lightweight notification daemon for Wayland
  hyprlock                          # Screen locker for Wayland
  networkmanagerapplet              # Graphical application for managing network connections
  cava                              # Console-based audio visualizer

  # Terminal & Development
  neofetch                          # Command-line system information tool
  neovim                            # Modern, extensible text editor based on Vim
  ranger                            # Console-based file manager with Vi-like keybindings
  vscode                            # Visual Studio Code, a source-code editor
  #nodejs_23                         # JavaScript runtime environment
  alacritty

  # Desktop Environment & Appearance
  waybar                            # Highly customizable status bar for Wayland compositors
  eww                               # Widgets
  rofi-wayland                      # Application launcher and window switcher for Wayland
  swww                              # Wayland compositor wallpaper manager
  papirus-icon-theme                # Icon theme for desktop environments
  bibata-cursors                    # Animated cursor theme
  catppuccin-gtk                    # GTK theme
  font-awesome                      # Icon font
  #nerdfonts                         # Collection of patched fonts with extra glyphs
  fira                              # Font family (likely Fira Code or Fira Sans)
  noto-fonts-emoji                  # Google's emoji font

  # Applications
  mpv                               # Media player
  imv                               # Image viewer (for Wayland)
  xfce.thunar                       # File manager from the XFCE desktop environment
  discord                           # Communication platform
  google-chrome                     # Web browser
  brave                             # Web browser
  ani-cli                           # Command-line anime player

  # Fonts
  nerd-fonts.jetbrains-mono
  nerd-fonts.fira-code
  nerd-fonts.space-mono
  font-awesome                      # Icon font
  fira                              # Font family (likely Fira Code or Fira Sans)
  noto-fonts-emoji                  # Google's emoji font
];

  # System Fonts
  fonts.fontconfig = {
    enable = true;
  };


  # Git configuration
  programs.git = {
    enable = true;
    userName = "PikachuUsedSurf";
    userEmail = "nanaosafokissi@gmail.com";
  };


  # Home Manager version
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  # Terminal configuration
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font Mono";  # Updated font name
      size = 12;
    };
    settings = {
      background_opacity = "0.95";
      window_padding_width = 8;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      
      # Explicitly set font fallbacks
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake /home/aurameow/NyaaOs#nixos";
      gs = "git status";
    };
    initExtra = ''
      neofetch
    '';
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./home-manager/hypr/hyprland.conf;
    plugins = [
      # pkgs.hyprlandPlugins.hyprspace
    ];kitty
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = [ (builtins.fromJSON (builtins.readFile ./home-manager/waybar/config.json)) ];
    style = builtins.readFile ./home-manager/waybar/style.css;
  };

  # Rofi configuration
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,filebrowser,window,power-menu:~/.config/rofi/power-menu.sh";
      show-icons = true;
      display-drun = "🌸 Apps";
      display-run = "🐾 Run";
      display-filebrowser = "📂 Files";
      display-window = "🪟 Windows";
      display-power-menu = "⏻ Power";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      window-format = "{w} · {c} · {t}";
      icon-theme = "Papirus";
    };
  #  theme = "./home-manager/rofi/config.rasi";
  };

  # For ozone-based applications
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # File configurations
  home.file.".config/waybar/modules.json".source = ./home-manager/waybar/modules.json;
  home.file.".config/hypr/wallpapers/default.jpg".source = ./home-manager/hypr/wallpapers/re1.jpg;
  #home.file.".config/hypr/themes/default/theme.conf".source = ./home-manager/hypr/themes/default/theme.conf;
  #home.file.".config/rofi/config.rasi".source = ./home-manager/rofi/config.rasi;
  home.file.".config/rofi/shared/colors.rasi".source = ./home-manager/rofi/shared/colors.rasi;
  home.file.".config/rofi/shared/fonts.rasi".source = ./home-manager/rofi/shared/fonts.rasi;
  home.file.".config/rofi/power-menu.sh" = {
    source = ./home-manager/rofi/power-menu.sh;
    executable = true;
  };
  home.file."scripts/rofi-wifi-menu/rofi-wifi-menu.sh" = {
    source = ./home-manager/waybar/rofi-wifi-menu.sh;
    executable = true;
  };

  home.file.".local/bin/theme-switch" = {
    executable = true;
    text = ''
      #!/bin/sh
      THEME="$HOME/.config/hypr/themes"
      WALLPAPERS="$HOME/.config/hypr/wallpapers"
      SELECTED=$(ls $THEME | rofi -dmenu -p "Select theme:" -theme ~/.config/rofi/config.rasi)
      if [ -z "$SELECTED" ]; then
        exit 0
      fi
      WALLPAPER=$(find "$WALLPAPERS/$SELECTED" -type f | shuf -n 1)
      if [ -n "$WALLPAPER" ]; then
        swww img "$WALLPAPER" --transition-type grow --transition-pos 0.9,0.1
      fi
      cp "$THEME/$SELECTED/theme.conf" "$HOME/.config/hypr/current_theme.conf"
      hyprctl reload
    '';
  };

  home.file.".local/bin/anime-fetch" = {
    executable = true;
    text = ''
      #!/bin/sh
      echo "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
      echo "  $(tput setaf 5)OS$(tput setaf 7): NyaaOS (NixOS)"
      echo "  $(tput setaf 5)WM$(tput setaf 7): Hyprland"
      echo "  $(tput setaf 5)Shell$(tput setaf 7): $(basename $SHELL)"
      echo "  $(tput setaf 5)Term$(tput setaf 7): $TERM"
      echo "  $(tput setaf 5)Packages$(tput setaf 7): $(ls /run/current-system/sw/bin | wc -l)"
      echo ""
    '';
  };
}
