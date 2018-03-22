#!/usr/bin/env bash

# Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'


[[ $EUID -ne 0 ]] && echo -e  "[${red}Error${plain}] This script must be run as root!\n${green}Maybe you want \"sudo ./newu.sh\"${plain}" && exit 1
echo -e "[${yellow}root access!${plain}]"

pre_install(){
    type wget &> /dev/null
    [[ $? -eq 0 ]] && apt-get update && apt-get install -y wget

}
add_repo(){
cat<<EOF > /etc/apt/sources.list.d/google-chrome.list
deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main
deb [arch=amd64] https://repo.fdzh.org/chrome/deb/ stable main
EOF

cat<<EOF > /etc/apt/sources.list
deb http://cn.archive.ubuntu.com/ubuntu/ artful main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu artful-security main restricted universe multiverse
deb http://cn.archive.ubuntu.com/ubuntu/ artful-updates main restricted universe multiverse
EOF
}

add_key(){
    wget -q  -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
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
    wget -q --no-check-certificate https://github.com/FelisCatus/SwitchyOmega/releases/download/v2.5.10/SwitchyOmega_Chromium.crx
    [ -e SwitchyOmega_Chromium.crx ] && [ -s SwitchyOmega_Chromium.crx ] && echo -e "${green}Downloaded SwitchyOmega_Chromium at current directory please open google-chrome install it!${green}"
    if ! [ -e SwitchyOmega_Chromium.crx ]
    then
        wget -q --no-check-certificate http://blog.cumtpn.com/SwitchyOmega_Chromium.crx
        [ -e SwitchyOmega_Chromium.crx ] && [ -s SwitchyOmega_Chromium.crx ] && echo -e "${green}Downloaded SwitchyOmega_Chromium at current directory please open google-chrome install it!${green}"
    fi

    echo -e "[${green}Ref${plain}]  https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList"
    echo -e "Import profile SwitchyOmega.bak"
    cat<<EOF > SwitchyOmega.bak
{"+GFWed":{"bypassList":[{"conditionType":"BypassCondition","pattern":"<local>"}],"color":"#99ccee","fallbackProxy":{"host":"127.0.0.1","port":1080,"scheme":"socks5"},"name":"GFWed","profileType":"FixedProfile","revision":"153abe56d04"},"+__ruleListOf_自动切换":{"color":"#99dd99","defaultProfileName":"direct","format":"AutoProxy","matchProfileName":"GFWed","name":"__ruleListOf_自动切换","profileType":"RuleListProfile","revision":"153abdf798a","ruleList":"","sourceUrl":"https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt","lastUpdate":null},"+自动切换":{"color":"#99dd99","defaultProfileName":"__ruleListOf_自动切换","name":"自动切换","profileType":"SwitchProfile","revision":"153abd3207f","rules":[{"condition":{"conditionType":"HostWildcardCondition","pattern":"raw.githubusercontent.com"},"profileName":"GFWed"}]},"-confirmDeletion":true,"-downloadInterval":1440,"-enableQuickSwitch":false,"-monitorWebRequests":true,"-quickSwitchProfiles":[],"-refreshOnProfileChange":true,"-revertProxyChanges":true,"-showInspectMenu":true,"-startupProfileName":"","schemaVersion":2}
EOF
}

install(){
    apt-get update
    apt-get install -y guake
    apt-get install -y vim
    apt-get install -y google-chrome-stable
    shadowsocks_install
    echo -e "${green}Please enter shadowsocks server:${plain}"
    while [[ -z "${ss_ip}" ]]; do
        read -p "shadowsocks server:" ss_ip
        [ -z ${ss_ip} ] && ss_ip=45.55.181.140
    done

    echo -e "${green}Please enter shadowsocks password:${green}"
    while [[ -z "${ss_pwd}" ]]; do
        read -p "shadowsocks password:" ss_pwd
        [ -z ${ss_pwd} ] && ss_pwd=waggywn@10000
    done

    echo -e "${green}Please enter shadowsocks port:${green}"
    read -p "shadowsocks port(Default 6566):" ss_port
    [[ -z ${ss_port} ]] && ss_port=6566

    echo -e "${green}Please enter shadowsocks method:${green}"
    read -p "shadowsocks method(Default aes-256-cfb):" ss_method
    [[ -z ${ss_method} ]] && ss_method="aes-256-cfb"

    sslocal -d start -q -s ${ss_ip} -p ${ss_port} -m ${ss_method} -k ${ss_pwd} -l 1080
    echo -e "${green}Start sslocal at 127.0.0.1:1080 ${green}"

    SwitchyOmega_install

}
pre_install
add_repo
add_key
install
