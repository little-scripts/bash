#!/bin/bash
set -e
# set +x

function show_help {
    echo "Usage: $0 --clean-pycache <path>"
    exit 1
}

# Check for required arguments
if [ $# -lt 2 ]; then
    show_help
fi

folder_name="__pycache__"

# Set options based on the first argument
case "$1" in
    --clean-pycache)
        # Count and display folder in the specified path
        dir_count=$(find "$2" -type d -name "$folder_name" | tee /dev/tty | wc -l)

        if [ "$dir_count" -eq 0 ]; then
            echo "[+] No folder(s) '$folder_name' found in $2."
        else
            echo "[+] Find '$dir_count' '$folder_name' in $2."

            read -p "[+] Do you want to remove these '$folder_name' folder(s)? (yes/no): " answer
            if [ "$answer" = "yes" ]; then
                find "$2" -type d -name "$folder_name" -exec rm -rf {} +
                echo "[+] Removed '$dir_count $folder_name'"
            else
                echo "[+] Aborted! "
            fi
        fi
        ;;
    *)
        echo "Invalid option: $1"
        show_help
        ;;
esac
