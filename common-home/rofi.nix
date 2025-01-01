{ config, pkgs, ... }:
{
  home.file.".config/rofi/config.rasi".text = ''
    @theme "/home/${home.username}/.config/rofi/theme.rasi"
  '';
  home.file.".config/rofi/theme.rasi".text = ''
    * {
      red:                         rgba ( 173, 160, 174, 100 % ); //highlight text
      selected-active-foreground:  var(background);
      lightfg:                     rgba ( 87, 82, 108, 100 % ); //highlight / select
      separatorcolor:              var(foreground);
      urgent-foreground:           var(red);
      alternate-urgent-background: var(lightbg);
      lightbg:                     rgba ( 92, 91, 90, 100 % );  // alt background
      background-color:            transparent;
      border-color:                var(blue);
      normal-background:           var(background);
      selected-urgent-background:  var(red);
      alternate-active-background: var(lightbg);
      spacing:                     2;
      blue:                        rgba ( 193, 143, 178, 100 % ); //outline
      alternate-normal-foreground: var(foreground);
      urgent-background:           var(background);
      selected-normal-foreground:  var(red);
      active-foreground:           var(blue);
      background:                  rgba ( 61, 61, 61, 100 % );  // background
      selected-active-background:  var(blue);
      active-background:           var(background);
      selected-normal-background:  var(lightfg);
      alternate-normal-background: var(lightbg);
      foreground:                  rgba ( 255, 255, 255, 100 % );  // text color
      selected-urgent-foreground:  var(background);
      normal-foreground:           var(foreground);
      alternate-urgent-foreground: var(red);
      alternate-active-foreground: var(blue);
    }

    element {
      padding: 1px ;
      cursor:  pointer;
      spacing: 5px ;
      border:  0;
      
    }
    element normal.normal {
      background-color: var(normal-background);
      text-color:       var(normal-foreground);
    }
    element normal.urgent {
      background-color: var(urgent-background);
      text-color:       var(urgent-foreground);
    }
    element normal.active {
      background-color: var(active-background);
      text-color:       var(active-foreground);
    }
    element selected.normal {
      background-color: var(selected-normal-background);
      text-color:       var(selected-normal-foreground);
    }
    element selected.urgent {
      background-color: var(selected-urgent-background);
      text-color:       var(selected-urgent-foreground);
    }
    element selected.active {
      background-color: var(selected-active-background);
      text-color:       var(selected-active-foreground);
    }
    element alternate.normal {
      background-color: var(alternate-normal-background);
      text-color:       var(alternate-normal-foreground);
    }
    element alternate.urgent {
      background-color: var(alternate-urgent-background);
      text-color:       var(alternate-urgent-foreground);
    }
    element alternate.active {
      background-color: var(alternate-active-background);
      text-color:       var(alternate-active-foreground);
    }
    element-text {
      background-color: transparent;
      cursor:           inherit;
      highlight:        inherit;
      text-color:       inherit;
    }
    element-icon {
      background-color: transparent;
      size:             1.0000em ;
      cursor:           inherit;
      text-color:       inherit;
    }
    window {
      padding:          8;
      background-color: var(background);
      border:           2;
      border-radius:    10;
    }
    mainbox {
      padding: 0;
      border:  0;
    }
    message {
      padding:      1px ;
      border-color: var(separatorcolor);
      border:       2px dash 0px 0px ;
    }
    textbox {
      text-color: var(foreground);
    }
    listview {
      padding:      2px 0px 0px ;
      scrollbar:    true;
      border-color: var(separatorcolor);
      spacing:      2px ;
      fixed-height: 0;
      border:       2px dash 0px 0px ;
    }
    scrollbar {
      width:        4px ;
      padding:      0;
      handle-width: 8px ;
      border:       0;
      handle-color: var(normal-foreground);
    }
    sidebar {
      border-color: var(separatorcolor);
      border:       2px dash 0px 0px ;
    }
    button {
      cursor:     pointer;
      spacing:    0;
      text-color: var(normal-foreground);
    }
    button selected {
      background-color: var(selected-normal-background);
      text-color:       var(selected-normal-foreground);
    }
    num-filtered-rows {
      expand:     false;
      text-color: Gray;
    }
    num-rows {
      expand:     false;
      text-color: Gray;
    }
    textbox-num-sep {
      expand:     false;
      str:        "/";
      text-color: Gray;
    }
    inputbar {
      padding:    1px ;
      spacing:    0px ;
      text-color: var(normal-foreground);
      children:   [ "prompt","textbox-prompt-colon","entry","num-filtered-rows","textbox-num-sep","num-rows","case-indicator" ];
    }
    case-indicator {
      spacing:    0;
      text-color: var(normal-foreground);
    }
    entry {
      text-color:        var(normal-foreground);
      cursor:            text;
      spacing:           0;
      placeholder-color: Gray;
      placeholder:       "Type to filter";
    }
    prompt {
      spacing:    0;
      text-color: var(normal-foreground);
    }
    textbox-prompt-colon {
      margin:     0px 0.3000em 0.0000em 0.0000em ;
      expand:     false;
      str:        ":";
      text-color: inherit;
    }
  '';
}