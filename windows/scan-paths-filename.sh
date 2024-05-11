#!/bin/bash
set -e
# set +x

function show_help {
    echo "Usage: $0 --scan-paths-filename <path> <file_name>"
    exit 1
}

# Check for required arguments
if [ $# -lt 3 ]; then
    show_help
fi

Options=$1
Path=$2
Filename=$3

# Set options based on the first argument
case "$Options" in
    --scan-paths-filename)
        # Count and display folder in the specified path
        count=$(find "$Path" -type f -name "*$Filename" | tee /dev/tty | wc -l)
        if [ "$count" -eq 0 ]; then
            echo "[+] No file(s) '$Filename' found in $Path."
        else
            echo "[+] Find $count file(s) '$Filename' in $Path."
        fi
            read -p "[+] Do you want to remove these '$Filename'? (yes/no): " answer
            if [ "$answer" = "yes" ]; then

                read -p "[+] Are you sure you want to delete these '$Filename'? (yes/no): " answer
                if [ "$answer" = "yes" ]; then
                    find "$Path" -type f -name "*$Filename" -exec rm -i {} +
                    echo "[+] Removed '$count $Filename'"
                else
                    echo "[+] Aborted!"
                fi

            else
                echo "[+] Aborted!"
            fi
        ;;
    *)
        echo "Invalid option: $Filename"
        show_help
        ;;
esac
