#!/usr/bin/env bash

# Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

[[ $EUID -ne 0 ]] && echo -e  "[${red}Error${plain}] This script must be run as root!" && exit 1
echo -e "[${yellow}root access!${plain}]"


pre_install(){
    type wget &> /dev/null
    [[ $? -eq 0 ]] && apt update && apt install wget
}
add_repo(){
cat<<EOF > /etc/apt/sources.list.d/google-chrome.list.back
deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
deb [arch=amd64] https://repo.fdzh.org/chrome/deb/ stable main
EOF
}

add_key(){
    wget -q  -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
}

# shadowsocks

shadowsocks_install(){
    pushd /tmp
    wget -q --no-check-certificate https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    rm get-pip.py
    pip install shadowsocks
    popd
}
SwitchyOmega_install(){
    pushd /tmp
    wget -q --no-check-certificate https://github.com/FelisCatus/SwitchyOmega/releases/download/v2.5.10/SwitchyOmega_Chromium.crx
    echo "${green}Downloaded SwitchyOmega_Chromium at /tmp please open google-chrome install it!${green}"
    google-chrome https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList
    popd
}
install(){
    apt-get update
    apt-get install google-chrome-stable
    shadowsocks_install
    echo "${green}Please enter shadowsocks server:${plain}"
    while [[ -z "${ss_ip}" ]]; do
        read -p "shadowsocks server:" ss_ip
    done

    echo "${green}Please enter shadowsocks port:${green}"
    read -p "shadowsocks port(Default 6566):" ss_port
    [[ -x ${ss_port} ]] && ss_port=6566

    echo "${green}Please enter shadowsocks method:${green}"
    read -p "shadowsocks method(Default aes256-cfb):" ss_method
    [[ -x ${ss_method} ]] && ss_method="aes256-cfb"

    echo "${green}Please enter shadowsocks password:${green}"
    while [[ -z "${ss_pwd}" ]]; do
        read -p "shadowsocks password:" ss_pwd
    done

    `sslocal -s ${ss_ip} -p ${ss_port} -m ${ss_method} -k ${ss_pwd} -l 1080 &`
    echo "${green}Start sslocal at 127.0.0.1:1080 ${green}"

    SwitchyOmega_install
}
pre_install
add_repo
add_key
install
