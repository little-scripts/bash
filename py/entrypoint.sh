#!/bin/bash

set -e

echo -e "\n--------------------------------------------------------------------"
echo -e " 🌍 \e[93mBy little-scripts developers | ❤️  Open Source\e[0m        "
echo -e "----------------------------------------------------------------------"

function show_help {
    echo -e "\nUsage: $0 <Options> <args>"
    echo -e "\nOptions:"
    echo -e "  --clean-pycache <path>                  Display and clean(yes/no) __pycache__ folders in the specified path"
    echo -e "  --clean-pytestcache <path>              Display and clean(yes/no) .pytest_cache folders in the specified path"
    echo -e "  --check-status-virtual-env-python       Check if a Python virtual environment is currently active"
    echo -e "  --get-system-info                       Get system info"
    exit 1
}



case "$1" in
-h)
    show_help
    ;;
--help)
    show_help
    ;;
--list)
    show_help
    ;;
--clean-pycache)
    if [ $# -lt 2 ]; then
        show_help
    fi
    source clean-pycache.sh
    ;;
--clean-pytestcache)
    if [ $# -lt 2 ]; then
        show_help
    fi
    source clean-pytestcache.sh
    ;;
--check-status-virtual-env-python)
    python -m check_status_virtual_env_python
    ;;
--get-system-info)
    python -m get_system_info
    ;;
*)
    show_help
    ;;
esac
