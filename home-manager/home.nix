{ config, pkgs, ... }:

{
    fonts.fontconfig.enable = true;

    home = {
        username = "romain.doulaud";
        homeDirectory = "/home/romain.doulaud";

        packages = with pkgs; [
            neofetch
            rofi
            tldr
            exa
            bat
            zsh
            picom
            ripgrep
            fd
            neovim

            # ccls
            # cmake-language-server

            (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
        ];

        stateVersion = "23.05";
    };

    programs = {
        home-manager.enable = true;
        # command-not-found.enable = true;
        alacritty = import ./alacritty.nix { inherit pkgs; };
    };

    manual = {
        html.enable = false;
        manpages.enable = false;
        json.enable = false;
    };
}
