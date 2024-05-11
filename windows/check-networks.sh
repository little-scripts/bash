#!/bin/bash
set -e
# set +x

# ---------------------------------- Commands -------------------------------
PUBLIC_IP=$(curl -s https://api.ipify.org)
ADDRESSES=$(netsh interface ipv4 show addresses)
ROUTES=$(netsh interface ipv4 show route)
ESTABLISHED=$(netstat -ano | grep ESTABLISHED)
LISTENING=$(netstat -ano | grep LISTENING)
DNS=$(netsh interface ipv4 show dns)
ARP=$(arp -a)

# ---------------------------------- Display Infos -------------------------------
echo -e "\n"
echo -e " 🌍 \e[93mINTERFACES ADDRESSES IPV4       "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${ADDRESSES}"

echo -e "\n"
echo -e " 🌍 \e[93mINTERFACES ROUTES IPV4       "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${ROUTES}"

echo -e "\n"
echo -e " 🌍 \e[93mCONNEXIONS ACTIVES: ESTABLISHED  "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${ESTABLISHED}"

echo -e "\n"
echo -e " 🌍 \e[93mCONNEXIONS ACTIVES: LISTENING  "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${LISTENING}"

echo -e "\n"
echo -e " 🌍 \e[93mDNS SERVER  "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${DNS}"

echo -e "\n"
echo -e " 🌍 \e[93mTABLE ARP "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${ARP}"

echo -e "\n"
echo -e " 🌍 \e[93mPUBLIC IP "
echo -e "----------------------------------------------------------------------"
echo -e "\e[33m\e[0m${PUBLIC_IP}"
