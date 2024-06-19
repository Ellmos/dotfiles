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
            bat
            zsh
            ripgrep
            fd
            flameshot

            # nvim
            neovim
            lua-language-server
            nodejs_20 # for images that do not have it by default

            # troll
            oneko

            # kern 
            bear
            bochs
            gccMultiStdenv
            grub2_full
            libisoburn
            qemu_kvm
            clang-tools
            grub2
            mtools

            (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
        ];

        stateVersion = "23.05";
    };

    programs = {
        home-manager.enable = true;
        # alacritty = import ./alacritty.nix { inherit pkgs; };
        # command-not-found.enable = true;
    };

    manual = {
        html.enable = false;
        manpages.enable = false;
        json.enable = false;
    };
}
