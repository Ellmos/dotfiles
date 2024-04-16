{ pkgs, ... }:

{
    enable = true;

    settings = {
        window = {
            opacity = 1;
            padding = {
                x = 9;
                y = 9;
            };
            dimensions = {
                columns = 80;
                lines = 24;
            };
            class = {
                instance = "Alacritty";
                general = "Alacritty";
            };
        };

        scrolling = {
            history = 20000;
            multiplier = 2;
        };

        font = {
            size = 11.0;
            family = "Hack Nerd Font";
            style = "Regular";
        };

        shell = {
            program = "${pkgs.zsh}/bin/zsh";
        };

        colors = {
            cursor = {
                text   = "0x000000";
                cursor = "0x888888";
            };
            primary = {
                background = "0x111111";
                foreground = "0xebdbb2";
            };
            normal = {
                black   = "0x100c1b";
                red     = "0xc11623";
                green   = "0x21a268";
                yellow  = "0xa2744a";
                blue    = "0x0a468c";
                magenta = "0xa444ba";
                cyan    = "0x24a3b4";
                white   = "0xd1d1cc";
            };
            bright = {
                black   = "0x6D7070";
                red     = "0xFF4352";
                green   = "0xB8E466";
                yellow  = "0xFFD750";
                blue    = "0x1BA6FA";
                magenta = "0xA578EA";
                cyan    = "0x73FBF1";
                white   = "0xFEFEF8";
            };
        };
    };
}
