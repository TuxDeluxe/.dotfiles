#!/usr/bin/env bash

# Set exit upon error and echo last command output as debug.
set -e
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# CD base directory.
source functions
INPUT=0
clear

main () {
source variables
if [ $INPUT == 1 ]; then
echo "";
echo -e "\e[31mERROR! PLEASE TYPE SELECTION EXACTLY AS SEEN!\e[0m";
echo "";
fi
INPUT=0
echo "Green = installed"
echo "Yellow = backup and installation detected (will overwrite backup of file(s) with current config before removing current config and installing new config)"
echo "Red = config not installed"
echo ""
echo "Selections..."
echo "$POLYBAR | $PICOM | $I3 | $SWAY | $WAYBAR | $KITTY | $FISH | $BASHRC | $PAM_ENVIRONMENT | $ZSHRC | $RANDOMIZEWALLPAPERS | cancel | ALL (DISABLED UNLESS EXLPICITYLY ENABLED (BE CAREFUL!))"
echo ""
while true; do
	read -p "Which config/file to install? (case sensitive)" unit
		case $unit in
			"polybar"	   	) clear; link ".config/polybar/config" ".config/polybar/launch.sh"; main;;
			"picom"   	   	) clear; link ".config/picom/picom.conf"; main;;
			"i3" 	   	   	) clear; link ".config/i3/config"; main;;
			"sway"   	   	) clear; link ".config/sway/config"; main;;
			"waybar"  	   	) clear; link ".config/waybar/config" ".config/waybar/style.css"; main;;
			"kitty"   	   	) clear; link ".config/kitty/kitty.conf"; main;;
			"fish"    	   	) clear; link ".config/fish/config.fish"; main;;
			".bashrc"  	   	) clear; link ".bashrc"; main;;
			".pam_environment" 	) clear; link ".pam_environment"; main;;
			".zshrc"	   	) clear; link ".zshrc"; main;;
			"randomizewallpapers"   ) clear; sed.randomizewallpapers; link ".config/systemd/user/randomizewallpapers.service" ".config/systemd/user/randomizewallpapers.timer"; link "bin/randomscript"; main;;
			"cancel"		) exit;;
			"ALL"			) clear; link ".config/polybar/config" ".config/polybar/launch.sh"; link ".config/picom/picom.conf"; link ".config/i3/config"; link ".config/sway/config"; link ".config/waybar/config" ".config/waybar/style.css"; link ".config/kitty/kitty.conf"; link ".config/fish/config.fish"; link ".bashrc"; link ".pam_environment"; link ".zshrc"; main;;
		esac
		clear
		INPUT=1
		main
done
exit
}

main
