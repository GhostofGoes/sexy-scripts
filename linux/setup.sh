#!/usr/bin/env bash

# Source: https://unix.stackexchange.com/a/41735
function os_type() {
case $(uname) in
  Linux )
     command -v dnf && { FEDORA=1; echo "dnf detected, definitely Fedora"; return; }
     command -v yum && { CENTOS=1; echo "yum detected, probably CentOS or RHEL"; return; }
     command -v zypper && { SUSE=1; echo "zypper detected, probably OpenSUSE"; return; }
     command -v apt-get && { DEBIAN=1; echo "apt-get detected, probably Debian"; return; }
     ;;
  Darwin )
     DARWIN=1
     ;;
  * )
     # Handle AmgiaOS, CPM, and modified cable modems here.
     ;;
esac
}

# Profile the OS
os_type

# TODO: proxy configs
# TODO: vscode
# TODO: go

useful_tools=(
    'tcpdump'       # Capture network traffic
    'tshark'        # Command-line Wireshark
    'wireshark'     # The penultimate network analysis toolkit
    'wireshark-doc' # Documentation for the above
    'snmp'          # snmpwalk and friends
    'snmp-mibs-downloader'  # SNMP MIBS
    'nmap'          # Network mapping/scanning

    'ipcalc'      # IP address/subnet calculator
    'mtr'         # Network diagnostic tool, basically an advanced traceroute
    'traceroute'  # The traditional traceroute tool
    'iftop'       # top for network interfaces, gives you nice network statistics and other infos
    'iptraf'      # Interactive Colorful IP LAN Monitor
    'nethogs'     # Net top tool grouping bandwidth per process
    'whois'       # Who are you? (Yeah, this isn't installed by default...)

    'cloc'      # Count lines of code
    'nano'      # Life not not complete without this
    'htop'      # Coloured and improved version of top
    'atop'      # Another resource monitoring tool
    'glances'   # Graphical resource monitoring tool
    'ncdu'      # Graphical view of directory sizes in terminal, using NCurses
)

if [ $DARWIN ]; then
    echo "I don't use OSX, sorry. If you put stuff here, please submit a PR or something."

elif [ $DEBIAN ]; then
    echo "Running setup for Debian or Debian-derivative. "
    # Update package cache, upgrade packages, and cleanup
    sudo apt-get update -y -qq
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y
    sudo apt-get autoremove -y

    # TODO: install apt packages
    sudo apt-get install -y -q build-essential
    sudo apt-get install -y -q shellcheck

    for i in "${useful_tools[@]}"; do
        sudo apt-get install -y -q "$i"
    done

    
    # TODO: base bashrc
    # TODO: detect WSL and do wsl bashrc
    # TODO: debian bashrc

elif [ $CENTOS ]; then
    echo "Running setup for CentOS. You masochist. "
    # Update package list and installed packages
    sudo yum update -y -q 

    # Add EPEL package repository
    sudo yum install -y -q epel-release

    # Install packages
    sudo yum install -y -q ShellCheck
    # TODO: this will probably fail on many of these
    for i in "${useful_tools[@]}"; do
        sudo yum install -y -q "$i"
    done

    # TODO: base bashrc
    # TODO: centos bashrc

elif [ $FEDORA ]; then
    echo "Running setup for Fedora, the OS we all wish we could run if everyone wasn't Debian-obscessed. "
    dnf -y check-update
    sudo dnf -y upgrade

    # Install packages
    sudo dnf install -y -q ShellCheck
    # TODO: this will probably fail on many of these
    for i in "${useful_tools[@]}"; do
        sudo dnf install -y -q "$i"
    done

    # TODO: base bashrc
    # TODO: fedora bashrc

elif [ $SUSE ]; then
    echo "Running setup for OpenSUSE. I don't use this yet, but might, so putting anything useful here for now."
    zypper in ShellCheck
    # TODO: update packages
    # TODO: install packages
    # TODO: bash bashrc
fi


# Install Python packages
while read -r py_package; do
    python3 -m pip install --user "$py_package"
done < ../python-packages.txt

