#!/bin/bash

set -e

echo -e "\n--------------------------------------------------------------------"
echo -e " 🌍 \e[93mBy little-scripts developers | ❤️  Open Source\e[0m        "
echo -e "----------------------------------------------------------------------"

function show_help {
    echo -e "\nUsage: $0 <Options> <args>"
    echo -e "\nOptions:"
    echo -e "  --scan-paths-filename <path> <file_name>        Display and clean(yes/no) files_name in the specified path"
    echo -e "  --scan-paths-foldername <path> <folder_name>    Display and clean(yes/no) folders_name in the specified path"
    echo -e "  --check-networks                                Check Networks"
    echo -e "  --check-server-is-actif <ip>                    Check Server is actif"
    exit 1
}


Options=$1

case "$Options" in
-h)
    show_help
    ;;
--help)
    show_help
    ;;
--scan-paths-filename)
    if [ $# -lt 2 ]; then
        show_help
    fi
    source scan-paths-filename.sh
    ;;
--scan-paths-foldername)
    if [ $# -lt 2 ]; then
        show_help
    fi
    source scan-paths-foldername.sh
    ;;
--check-networks)
    source check-networks.sh
    ;;
--check-server-is-actif)
    if [ $# -lt 2 ]; then
        show_help
    fi
    python -m check_server_is_actif --host "$2"
    ;;
*)
    show_help
    ;;
esac
