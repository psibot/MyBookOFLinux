#!/bin/bash
# SCRIPT:
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: Linux Anon Surf - ALLWAYS
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################
# Run as root.
if [[ $EUID -ne 0 ]]; then
    echo -e  "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e  "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e  "\e[1mMust be ROOT to run  this script!\e[0m"
    exit
fi

export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export COLOR_NC='\e[0m' # No Color
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'

apt-get -qq -y install proxychains macchanger openvpn tor-geoipdb tclgeoip geoip-database geoip-bin geoipupdate mmdb-bin libgeoip-dev

curl -s checkip.amazonaws.com >> /dev/null
curl -s ifconfig.me >> /dev/null
curl -s icanhazip.com >> /dev/null
curl -s ipecho.net/plain >> /dev/null
curl -s ifconfig.co >> /dev/null
## store output in $server_ip ##
server_ip="$(curl -s ifconfig.co)" >> /dev/null
## Display it ##
printf "Server public IP :  %s\n" $server_ip
service tor stop

##########################################################
################ BEGINNING OF MAIN #######################
##########################################################

function sudouser() {
    clear
    echo
    echo -e "Setup User for sudo WITHOUT PASSWORD Prompt "
    echo
    echo "Type in the user name that will get sudo role "
    read usersudo
    echo "$usersudo ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$usersudo
    chmod 0440 /etc/sudoers.d/$usersudo
    echo
}


function setuprepos() {
    rm -f /etc/apt/sources.list.d/i2p.list

   # Compile the i2p ppa
   echo "deb http://deb.i2p2.no/ unstable main" > /etc/apt/sources.list.d/i2p.list # Default config reads repos from sources.list.d
   wget https://geti2p.net/_static/i2p-debian-repo.key.asc -O /tmp/i2p-debian-repo.key.asc # Get the latest i2p repo pubkey
   apt-key add /tmp/i2p-debian-repo.key.asc # Import the key
   rm /tmp/i2p-debian-repo.key.asc # delete the temp key
   add-apt-repository ppa:maxmind/ppa
   apt-get -qq -y update # Update repos

    if [[ -n $(cat /etc/os-release |grep kali) ]]
    then
	apt-get -qq install libservlet3.0-java
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
	dpkg -i libjetty8-java_8.1.16-4_all.deb # This should succeed without error
	apt-get install -gg libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni #installs i2p and other dependencies
	apt-get -f install # resolves anything else in a broken state
    fi

    apt-get install -y -qq i2p-keyring #this will ensure you get updates to the repository's GPG key
    apt-get install -y -qq secure-delete tor i2p # install dependencies, just in case

}


function anoninstall()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Need Repo's and software!!! This will take TIME..  \e[0m"
    echo
    echo "Installing system"
    echo
    clear
    setuprepos
    echo
    echo -e "\e[32m[-]\e[0m \e[1m This will take a moment to run \e[0m"
    apt-get -qq  update >> /dev/null
    apt-get -qq -y install proxychains macchanger openvpn tor-geoipdb tclgeoip geoip-database geoip-bin geoipupdate mmdb-bin libgeoip-dev  inetutils-traceroute traceroute
    apt-get -qq -y install python3 python3-pip  python-urwid-doc wmctrl python3-tk geoipupdate python3-geoip python3-geoip2 python3-pygeoip tesseract-ocr imagemagick
    apt-get -qq -y install gir1.2-appindicator3-0.1 gir1.2-notify-0.7 python-gobject texlive-latex-extra texlive-latex-recommended xcolmix xcolors xcolorsel
    apt-get install -y -qq secure-delete tor i2p masscan # install dependencies, just in case
    pip3 install shodan
    pip3 install aiohttp
    pip3 install aiodns
    pip3 install proxybroker
    clear
    echo -e "\e[32m[-]\e[0m \e[1m Install Latest PROXYCHAINS \e[0m"
    echo
    rm -fr proxychains*
    git clone --recursive https://github.com/rofl0r/proxychains-ng.git
    cd proxychains-ng
    ./configure
    make
    make install
    cd ../
    echo
    echo
    clear
    echo
    echo -e "\e[31m[!!]\e[0m \e[1m Done! \e[0m"
    sleep 2
    clear
    echo -e "\e[32m[-]\e[0m \e[1m Version Check  \e[0m"
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Proxy Chains  \e[0m"
    echo
    proxychains
    echo
    proxychains4
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** MAC Changer  \e[0m"
    echo
    macchanger -V
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Shodan Version  \e[0m"
    echo
    shodan version
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** TOr Version  \e[0m"
    echo
    tor  --version
    torify  --version
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** i2p Version  \e[0m"
    echo
    i2pd  --version
    echo
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Maxmind Geoip Versions  \e[0m"
    echo
    geoipupdate -V
    echo
    geoiplookup -v 8.8.8.8
    echo
    read -p "Press [Enter] to continue..."
}

function getgit() {
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Git REPOS and Tools  !!! This will take TIME..  \e[0m"
    echo
    echo "Installing system"
    echo
    echo
    echo -e "\e[32m[-]\e[0m \e[1m KALI AnonSurf  \e[0m"
    echo
    rm -fr  kali-anonsurf # cleanup
    git clone --recursive  https://github.com/Und3rf10w/kali-anonsurf.git
    echo
    cd kali-anonsurf
    # Configure and install the .deb
    dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb # Build the deb package
    dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb) # this will automatically install the required packages
    cd ../
    echo
    clear
    echo
    echo -e "\e[32m[-]\e[0m \e[1m WindowS  AnonSurf  \e[0m"
    echo
    sleep 5
    rm -fr AnonSurf >> /dev/null # cleanup
    git clone --recursive https://github.com/ultrafunkamsterdam/AnonSurf.git
    echo
    echo
    echo -e "\e[32m[-]\e[0m \e[1m ProxyBroker   \e[0m"
    echo
    sleep 5
    rm -fr ProxyBroker >> /dev/null # cleanup
    git clone --recursive https://github.com/constverum/ProxyBroker.git
    pip3 install -U git+https://github.com/constverum/ProxyBroker.git
    echo
    echo
    echo -e "\e[32m[-]\e[0m \e[1m ProxyChain Forger    \e[0m"
    echo
    sleep 5
    rm -fr Chainforger >> /dev/null # cleanup
    git clone --recursive https://github.com/sleeyax/Chainforger.git
    echo
    echo -e "\e[32m[-]\e[0m \e[1m ProxyChain Scrape    \e[0m"
    echo
    sleep 5
    rm -fr proxy-scrape >> /dev/null # cleanup
    git clone --recursive https://github.com/vesche/proxy-scrape.git
    echo
    echo
    echo -e "\e[32m[-]\e[0m \e[1m Vpngate-with-proxy  \e[0m"
    echo
    sleep 5
    rm -fr  vpngate-with-proxy  >> /dev/null # cleanup
    git clone --recursive https://github.com/Dragon2fly/vpngate-with-proxy.git
    cd vpngate-with-proxy
    echo
    echo "You will be promted to setup VPN GATE !!!"
    echo
    echo -e  "\e[31m[-]\e[0m \e[1m  TO EXIT HIT q \e[0m"
    echo
    read -p "Press [Enter] to continue..."
    echo
    ./run
    clear




}

function serviceshow()
{
    clear
    echo -e "\e[32m[-]\e[0m \e[1m Version Check  \e[0m"
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Proxy Chains  \e[0m"
    echo
    proxychains
    echo
    proxychains4
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** MAC Changer  \e[0m"
    echo
    macchanger -V
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Shodan Version  \e[0m"
    echo
    shodan version
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** TOr Version  \e[0m"
    echo
    tor  --version
    torify  --version
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** i2p Version  \e[0m"
    echo
    i2pd  --version
    echo
    echo
    echo -e "\e[31m[V]\e[0m \e[1m ***** Maxmind Geoip Versions  \e[0m"
    echo
    geoipupdate -V
    echo
    geoiplookup -v 8.8.8.8
    echo
    read -p "Press [Enter] to continue..."

}


function show_menus()
  {

  echo
  echo
  echo -e "\e[40;38;5;82m [++] \e[30;48;5;82m  Ubuntu / Kali AnonSurf  \e[0m "
  echo
  echo
  echo -e "\e[32m[--]\e[0m \e[1m  Choose : Hit 'a' for - Install Need Repositories And Packages \e[0m"
  echo -e "\e[32m[--]\e[0m \e[1m  Choose : Hit 'b' for - Install Setup User with SUDO Noprompt \e[0m"
  echo -e "\e[32m[--]\e[0m \e[1m  Choose : Hit 'x' for - Exit \e[0m"
  echo
  echo -e "\e[32m[+]\e[0m \e[1m  Choose : Hit '1' for - Versions of Tools  \e[0m"
  echo -e "\e[32m[+]\e[0m \e[1m  Choose : Hit '2' for - Info on Current IP and Location  \e[0m"
  echo -e "\e[32m[+]\e[0m \e[1m  Choose : Hit '3' for - Starts Anon Services with TOR Socks  \e[0m"
  echo -e "\e[32m[+]\e[0m \e[1m  Choose : Hit '4' for - Starts Anon Services with over OPENVPN Gateway - SLOW BUT SAFE \e[0m"
  echo

  echo "Pick Option:"
  }


function firstrun()
{
  clear
  echo
  echo -e "\e[31m[!!]\e[0m \e[1m First Time INSTALL ALL FIRST option :a   \e[0m"
  echo -e "\e[31m[!!]\e[0m \e[1m FYI You will need shodan / Setup a account and install the API with API Key  \e[0m"
  echo
  echo -e  "\e[31m[+]\e[0m \e[92m Your Public WAN IP: \e[5m \e[1;31;42m  $server_ip   \e[0m "
  echo
  echo -e "\e[31m[+]\e[0m \e[92m Server Geolocation:\e[0m " ; geoiplookup -I $server_ip
  echo
  read -p "Press [Enter] to continue..."

}

function startanon()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+++] \e[30;48;5;82m Starting Anon Tor Service  \e[0m"
    anonsurf start
    sleep 5
    clear
    echo
    echo -e "\e[40;38;5;82m [+++] \e[30;48;5;82m You should see WAN IP changed to A TOR IP  \e[0m"
    echo
    anonsurf myip


}


function mygeoip()
{
    clear
    echo
    echo -e  "\e[31m[+]\e[0m \e[92m Your Public WAN IP: \e[5m \e[1;31;42m  $server_ip   \e[0m "
    echo
    echo -e "\e[31m[+]\e[0m \e[92m Server Geolocation:\e[0m " ; geoiplookup -I $server_ip
    echo
    read -p "Press [Enter] to continue..."

}

function startvpn()
{
    echo
    echo
    echo -e "\e[32m[-]\e[0m \e[1m Vpngate-with-proxy  \e[0m"
    echo
    sleep 5
    cd vpngate-with-proxy
    echo
    echo -e  "\e[31m[-]\e[0m \e[1m KEEP THIS TERMINAL OPEN / CLOSE IT AND SERVICE WILL STOP  \e[0m"
    echo
    echo -e  "\e[31m[-]\e[0m \e[1m  TO EXIT HIT q \e[0m"
    echo
    read -p "Press [Enter] to continue..."
    echo
    ./run
    clear
}


  firstrun
  show_menus
  read choice

if [ "$choice" == a ]; then
    clear
    anoninstall
    getgit
    show_menus
    read choice
 fi

if [ "$choice" == b ]; then
    clear
    sudouser
    clear
    show_menus
    read choice
 fi

if [ "$choice" == 1 ]; then
    clear
    serviceshow
    clear
    show_menus
    read choice
fi

 if [ "$choice" == 2 ]; then
    clear
    mygeoip
    clear
    show_menus
    read choice
 fi


  if [ "$choice" == 3 ]; then
    clear
    sleep 2
    startanon
    echo
    clear
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m the AnonSurf Program Is Loaded \e[0m"
    echo
    anonsurf
    sleep 5
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m AND ALWAYS RUN COMMANDS WITH SUDO !!!\e[0m"
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m AND ALWAYS RUN COMMANDS WITH SUDO !!!\e[0m"
    sleep 5
    fi

  if [ "$choice" == 4 ]; then
    clear
    sleep 2
    startvpn
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
    exit 0
    fi


  if [ "$choice" == x ]; then
    clear
    sleep 2
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
    echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
    exit 0
  fi





####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script
