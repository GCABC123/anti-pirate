#!/bin/bash

# Display a simple banner
echo "====================="
echo "   Anti-Piracy Tool  "
echo "====================="

# Define main menu function
main_menu() {
    while true; do
        echo ""
        echo "Supported executable formats: .exe (Windows), .dll (Windows), .apk (Android)"
        echo ""
        echo "1. Encode Executable File"
        echo "2. Exit"
        echo ""
        read -p "Select an option: " choice
        case $choice in
            1)
                # Check if encode_payload.py exists
                SCRIPT_PATH="./resources/scripts/encode_payload.py"
                if [[ -f "$SCRIPT_PATH" ]]; then
                    echo "Encoding payload into executable file..."
                    
                    # Run the encoding Python script and capture any errors
                    if python3 "$SCRIPT_PATH"; then
                        echo "Encoding completed successfully."
                    else
                        echo "Error: Encoding failed. Please check the script and try again."
                    fi
                else
                    echo "Error: Script $SCRIPT_PATH not found. Please ensure the path is correct."
                fi
                ;;

            2)
                echo "Exiting..."
                exit 0
                ;;
            *)
                echo "Invalid option, please choose again."
                ;;
        esac
    done
}

# Run the main menu function
main_menu
