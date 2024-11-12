#!/bin/bash
# by Osaroprime
# GENERAL CONSULTING ABC 123 BY OSAROPRIME
# ANTI-PIRATE ™ DEMO
# MAGNETRON TECHNOLOGY ™ RESEARCH SCRIPT.


# ANTI-PIRATE ™
# color
# Reset

clear='\033[0m'       # Text Reset
clr='\033[0m'
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# ANTI-PIRATE ™ VERSION NUMBER
version=1.0


# Define the number of lines in the banner (important for locking it at the top)
BANNER_LINES=23  # Increased for more space after the banner

# Show the static banner
show_banner() {
    tput cup 0 0
    echo -e "${clr}\n"
    printf "${BPurple} ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★\n"
    printf "${BYellow}  █████╗ ███╗   ██╗████████╗██╗      ██████╗ ██╗██████╗  █████╗ ████████╗███████╗\n"
    printf "${BYellow} ██╔══██╗████╗  ██║╚══██╔══╝██║      ██╔══██╗██║██╔══██╗██╔══██╗╚══██╔══╝██╔════╝\n"
    printf "${BYellow} ███████║██╔██╗ ██║   ██║   ██║█████╗██████╔╝██║██████╔╝███████║   ██║   █████╗  \n"
    printf "${BCyan} ██╔══██║██║╚██╗██║   ██║   ██║╚════╝██╔═══╝ ██║██╔══██╗██╔══██║   ██║   ██╔══╝  \n"
    printf "${BCyan} ██║  ██║██║ ╚████║   ██║   ██║      ██║     ██║██║  ██║██║  ██║   ██║   ███████╗\n"
    printf "${BCyan} ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝      ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝\n"
    printf "${BRed}SOFTWARE ANTI-PIRACY TOOL (BASIC/SINGLE USER) DEMO 🏴‍☠️\n"
    printf "=========================================================================================\n"
    printf "${White}by: ${BGreen}Osaroprime☢\n"
    printf "${White}by: ${BGreen}GENERAL CONSULTING ABC 123 BY OSAROPRIME ™  ☢\n"
    printf "${White}id: ${BGreen}MAGNETRON TECHNOLOGY ™ RESEARCH: LUCI-4 ☢\n"
    printf "${BGreen}GitHub Sponsors link: https://github.com/sponsors/GCABC123     \n"
    printf "${BGreen}Company links: https://linktr.ee/ABC123USA   \n"
    printf "${BGreen}Version ${BRed}$version \n"

    printf "${BPurple} ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★\n"
    echo ""
}







# Initialize the terminal for a static banner
init_static_banner() {
    clear
    show_banner
    tput cup $BANNER_LINES 0
}






# Function to check for upgrades
check_for_upgrades() {
    echo -e "${Cyan}Checking for updates...${clear}"
    sudo brew update
    sudo brew upgrade metasploit msfvenom ffmpeg cmatrix
    echo -e "${Cyan}Update check completed!${clear}"
}

# Request sudo password once
if sudo -v; then
    # Keep sudo alive for the duration of the script
    while true; do sudo -n true; sleep 60; done 2>/dev/null &
else
    echo "Sudo access is required. Exiting..."
    exit 1
fi



# Start the update tasks, suppressing output
check_for_upgrades > /dev/null 2>&1 &
CHECK_UPGRADES_PID=$!  # Save the PID of check_for_upgrades


# Play audio in the background, loop the music infinitely with -loop 0
ffplay -v 0 -nodisp -loop 0 ./resources/audio/audio.mp3 &
FFPLAY_PID=$!  # Save the PID of ffplay

# Trap EXIT signal to ensure ffplay process is terminated when the session exits
trap "kill -9 $FFPLAY_PID" EXIT

# Start cmatrix 
cmatrix -bs 
CMATRIX_PID=$!  # Save the PID of cmatrix
trap "kill -9 $CMATRIX_PID" EXIT


# Wait for both tasks to complete
wait $CHECK_UPGRADES_PID

# Output the success message
echo "Resources updated successfully!"



# Stop cmatrix and ffplay after the updates finish
kill -9 $CMATRIX_PID
kill -9 $FFPLAY_PID &
echo "Tasks completed and cmatrix/ffplay stopped."





# Main encoding menu
main_menu() {
    echo ""
    ffplay -v 0 -nodisp ./resources/audio/audio2.mp3 & # Play audio before reading output file input
    read -p "Enter the file name of the executable (in this directory): " input_file
    if [[ ! -f "$input_file" ]]; then
        echo -e "${BRed}Error: File does not exist!${clear}"
        exit 1
    fi

    validate_file_type "$input_file"
    
    ffplay -v 0 -nodisp ./resources/audio/audio2.mp3 & # Play audio before reading output file input
    read -p "Enter output file name (without extension): " output_file
    output_file="${output_file}.${input_file##*.}"

    encode_payload "$input_file" "$output_file" || exit 1
}

# Banner and run the main menu function
init_static_banner
main_menu
