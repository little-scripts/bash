#!/bin/bash
set -e
# set +x

function show_help {
    echo "Usage: $0 --scan-paths-foldername <path> <file_name>"
    exit 1
}

# Check for required arguments
if [ $# -lt 3 ]; then
    show_help
fi

folder_name="$3"

# Set options based on the first argument
case "$1" in
    --scan-paths-foldername)
        # Count and display folder in the specified path
        folder_count=$(find "$2" -type d -name "$folder_name" | tee /dev/tty | wc -l)

        if [ "$folder_count" -eq 0 ]; then
            echo "[+] No folder(s) '$folder_name' found in $2."
        else
            echo "[+] Find $folder_count folder(s) '$folder_name' in $2."

            read -p "[+] Do you want to remove these '$folder_name' dirs? (yes/no): " answer
            if [ "$answer" = "yes" ]; then

                read -p "[+] Are you sure you want to delete these '$folder_name'? (yes/no): " answer
                if [ "$answer" = "yes" ]; then
                    find "$2" -type d -name "*$folder_name" -exec rm -rf {} +
                    echo "[+] Removed '$folder_count $folder_name'"
                else
                    echo "[+] Aborted!"
                fi

            else
                echo "[+] Aborted!"
            fi
        fi
        ;;
    *)
        echo "Invalid option: $1"
        show_help
        ;;
esac
