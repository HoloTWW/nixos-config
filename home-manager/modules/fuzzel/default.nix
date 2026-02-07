{config, pkgs, ...}: {
    
    programs.fuzzel.enable = true;

    programs.fuzzel.settings = {
        
        main = {
            font = "JetBrainsMono Nerd Font:size=12";
            icon-theme = "Papirus-Dark";
            placeholder = "'ll find them all...";
            terminal = "alacrity";
            prompt = "\"❯ \"";
            layer = "top";
            anchor = "center";
            y-margin = 30;
            width = 40;
            horizontal-pad = 40; # px
            vertical-pad = 10; # py
            inner-pad = 5;
            line-height = 20;
            letter-spacing = 0;
            image-size-ratio = 0.5;
            fields = "filename,name,generic,exec";
            sort-result = "yes";
        };

        colors = {
            prompt = "3a6754ff"; #3a6754ff
            input = "ffffffff"; #ffffffff
            placeholder = "7c818cff"; #7c818cff
            background =  "383c4aff"; #383c4aff
            text = "7c818cff"; #7c818cff
            match = "ffffffff"; #ffffffff
            selection = "3a6754ff"; #3a6754ff
            selection-text = "ffffffff"; #ffffffff
            selection-match = "ffffffff"; #ffffffff
            border = "3a6754ff"; #3a6754ff"            
        };

        border = {
            width = 3;
            radius = 12;
            selection-radius = 6;
        };

        drun = {
            filter-desktop = "yes";
            show-actions = "no";
        };  
    };

}