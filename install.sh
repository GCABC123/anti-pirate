#!/bin/bash
# by Osaroprime
# GENERAL CONSULTING ABC 123 BY OSAROPRIME
# ANTI-PIRATE ™ (BASIC) DEMO 
# MAGNETRON TECHNOLOGY ™ RESEARCH INSTALLATION SCRIPT.

# Function to install Homebrew if not installed
install_homebrew() {
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -ne 0 ]; then
        echo "Homebrew installation failed!"
        exit 1
    fi
    echo "Homebrew installed successfully!"
}


# Request sudo password once
if sudo -v; then
    # Keep sudo alive for the duration of the script
    while true; do sudo -n true; sleep 60; done 2>/dev/null &
else
    echo "Sudo access is required. Exiting..."
    exit 1
fi




# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    install_homebrew
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update




# Path to the requirements.txt file in the same directory as this script
REQUIREMENTS_FILE="./requirements.txt"

# Check if requirements.txt exists
if [[ ! -f "$REQUIREMENTS_FILE" ]]; then
    echo "Error: requirements.txt not found!"
    exit 1
fi

# Loop through each line in requirements.txt
while IFS= read -r package; do
    if [[ ! -z "$package" && ! "$package" =~ ^# ]]; then
        # Echo message before installing/upgrading each package
        echo "Installing or upgrading $package..."

        # Check if the package is already installed
        if ! brew list --formula | grep -q "^$package\$"; then
            # If not installed, install the package
            brew install "$package"
        else
            # If already installed, upgrade it to the latest version
            brew upgrade "$package"
        fi
    fi
done < "$REQUIREMENTS_FILE"

echo "All specified packages installed or upgraded."






echo "Download & setup of ANTI-PIRATE ™ DEMO is complete!"








# ASCII Banner with Bold Red Color
cat << "EOF"




                                .do-"""""'-o..                         
                             .o""            ""..                       
                           ,,''                 ``b.                   
                          d'                      ``b                   
                         d`d:                       `b.                 
                        ,,dP                         `Y.               
                       d`88                           `8.               
 ooooooooooooooooood888`88'                            `88888888888bo, 
d"""    `""""""""""""Y:d8P                              8,          `b 
8                    P,88b                             ,`8           8 
8                   ::d888,                           ,8:8.          8 
:                   dY88888                           `' ::          8 
:                   8:8888                               `b          8 
:                   Pd88P',...                     ,d888o.8          8 
:                   :88'dd888888o.                d8888`88:          8 
:                  ,:Y:d8888888888b             ,d88888:88:          8 
:                  :::b88d888888888b.          ,d888888bY8b          8 
                    b:P8;888888888888.        ,88888888888P          8 
                    8:b88888888888888:        888888888888'          8 
                    8:8.8888888888888:        Y8888888888P           8 
,                   YP88d8888888888P'          ""888888"Y            8 
:                   :bY8888P"""""''                     :            8 
:                    8'8888'                            d            8 
:                    :bY888,                           ,P            8 
:                     Y,8888           d.  ,-         ,8'            8 
:                     `8)888:           '            ,P'             8 
:                      `88888.          ,...        ,P               8 
:                       `Y8888,       ,888888o     ,P                8 
:                         Y888b      ,88888888    ,P'                8 
:                          `888b    ,888888888   ,,'                 8 
:                           `Y88b  dPY888888OP   :'                  8 
:                             :88.,'.   `' `8P-"b.                   8 
:.                             )8P,   ,b '  -   ``b                  8 
::                            :':   d,'d`b, .  - ,db                 8 
::                            `b. dP' d8':      d88'                 8 
::                             '8P" d8P' 8 -  d88P'                  8 
::                            d,' ,d8'  ''  dd88'                    8 
::                           d'   8P'  d' dd88'8                     8 
 :                          ,:   `'   d:ddO8P' `b.                   8 
 :                  ,dooood88: ,    ,d8888""    ```b.                8 
 :               .o8"'""""""Y8.b    8 `"''    .o'  `"""ob.           8 
 :              dP'         `8:     K       dP''        "`Yo.        8 
 :             dP            88     8b.   ,d'              ``b       8 
 :             8.            8P     8""'  `"                 :.      8 
 :            :8:           :8'    ,:                        ::      8 
 :            :8:           d:    d'                         ::      8 
 :            :8:          dP   ,,'                          ::      8 
 :            `8:     :b  dP   ,,                            ::      8 
 :            ,8b     :8 dP   ,,                             d       8 
 :            :8P     :8dP    d'                       d     8       8 
 :            :8:     d8P    d'                      d88    :P       8 
 :            d8'    ,88'   ,P                     ,d888    d'       8 
 :            88     dP'   ,P                      d8888b   8        8 
 '           ,8:   ,dP'    8.                     d8''88'  :8        8 
             :8   d8P'    d88b                   d"'  88   :8        8 
             d: ,d8P'    ,8P""".                      88   :P        8 
             8 ,88P'     d'                           88   ::        8 
            ,8 d8P       8                            88   ::        8 
            d: 8P       ,:  -hrr-                    :88   ::        8 
            8',8:,d     d'                           :8:   ::        8 
           ,8,8P'8'    ,8                            :8'   ::        8 
           :8`' d'     d'                            :8    ::        8 
           `8  ,P     :8                             :8:   ::        8 
            8, `      d8.                            :8:   8:        8 
            :8       d88:                            d8:   8         8 
 ,          `8,     d8888                            88b   8         8 
 :           88   ,d::888                            888   Y:        8 
 :           YK,oo8P :888                            888.  `b        8 
 :           `8888P  :888:                          ,888:   Y,       8 
 :            ``'"   `888b                          :888:   `b       8 
 :                    8888                           888:    ::      8 
 :                    8888:                          888b     Y.     8, 
 :                    8888b                          :888     `b     8: 
 :                    88888.                         `888,     Y     8: 
 ``ob...............--"""""'----------------------`""""""""'"""`'"""""                                 
                                              
EOF

echo -e "\033[1;31mInstallation of "ANTI-PIRATE (BASIC) v 1.0™ DEMO" was successful! 👽 Enjoy!\033[0m"
cmatrix -bs 




