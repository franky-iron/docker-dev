@echo off
setlocal enabledelayedexpansion
    wsl -u root ip addr add 172.18.227.237/28 broadcast 192.168.1.46 dev eth0 label eth0:1
    netsh interface ip add address "vEthernet (WSL)" 172.18.227.1 255.255.254.0
    echo set windows ip success: 172.18.227.1
exit