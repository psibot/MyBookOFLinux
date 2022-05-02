#!/bin/bash
# SCRIPT: server-setup.sh
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: ROOT Kube control
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################

##########################################################
################ BEGINNING OF MAIN #######################
##########################################################

function pause(){
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
}

function users-s()
{
    cls
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will setup your user on New Server  \e[0m"
    echo
    echo "SetUp User "
    echo
    echo -e "What user should we setup for sudo - type the username"
    read uss
    echo
    adduser $uss
    echo "$uss ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$uss
    sudo chmod 0440 /etc/sudoers.d/$uss
    echo
    echo -e "Done"
    pause

  }

function setup-Laptop()
  {
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing  System !!!  \e[0m"
      echo
      echo "This will take time"
      echo
      echo -e "What Version of Ubuntu exmaple : 18.04"
      echo
      read ubver
      echo
      pause
      echo
      sudo apt update
      echo
      clear
      echo
      echo -e "IT's \e[5mRUNNING IN SILENT MODE !!! \e[25mErorrs will show."
      echo
      sudo apt-get -qq -y install vim* git  forensic*
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Snap Packages !!!  \e[0m"
      echo
      sudo snap install orchis-themes
      sudo snap install chromeos-themes
      sudo snap install ttvdesktop
      sudo snap install good-job
      sudo snap install tela-icons
      sudo snap install wonderwall
      sudo snap install wallpaperdownloader
      sudo snap install discord
      sudo snap install aetherp2p
      sudo snap install i2pi2p --edge
      sudo snap install easy-openvpn-server --candidate
      sudo snap install qownnotes
      sudo snap install youtube-dl
      sudo snap install buka
      sudo snap install audible-for-linux
      sudo snap install rpi-imager
      sudo snap install easy-installer --beta
      sudo snap install midterm
      sudo snap install obs-studio
      sudo snap install filmographer
      sudo snap install sublime-text --classic
      sudo snap install circleci
      sudo snap install netron
      sudo snap install opencomic
      sudo snap install cu-ddns
      sudo snap install janlochi-zigbee2mqtt --edge
      sudo snap install micropad
      sudo snap install cacher
      sudo snap install termius-beta
      sudo snap install snowflake
      sudo snap install termius-app
      sudo snap install sftpclient
      sudo snap install keepassxc
      sudo snap install termius-beta
      sudo snap install cacher
      sudo snap install codechecker --classic
      sudo snap install slack --classic
      sudo snap install whatsdesk
      sudo snap install zoom-client
      sudo snap install teams-for-linux
      sudo snap install prospect-mail
      sudo snap install giara --beta
      sudo snap install telegram-desktop
      sudo snap install bitwarden
      sudo snap install dm-tools
      sudo snap install csbooks
      sudo snap install phpstorm --classic
      sudo snap install intellij-idea-community --classic
      sudo snap install brackets --classic
      sudo snap install go --classic
      sudo snap install clion --classic
      sudo snap install pycharm-educational --classic
      sudo snap install code --classic
      sudo snap install ant --classic
      sudo snap install kotlin --classic
      sudo snap install flutter --classic
      sudo snap install goland --classic
      sudo snap install cmake --classic
      sudo snap install kompare
      sudo snap install fuzzit
      sudo snap install goreleaser --classic
      sudo snap install aliasman
      sudo snap install gisto
      sudo snap install codechecker --classic
      sudo snap install rem --classic
      sudo snap install pigmeat
      echo
      clear


              echo
              echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Install FLATPACK   ... \e[0m"
              echo
              echo
              sudo apt install flatpak
              sudo apt install gnome-software-plugin-flatpak
              flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
              echo
              echo -e "Done"
              sleep 5
              clear


      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Software ... \e[0m"
      echo
      echo
      echo
      echo -e "IT's \e[5mRUNNING IN SILENT MODE !!! \e[25mErorrs will show."
      echo
      sudo apt update
      sudo apt-get -qq install -y git python3 python3-pip rmlint-gui bleachbit curl wine64 wget vim sed netcat  build-essential cmake vim-nox python3-dev jq mono-complete golang nodejs default-jdk npm
      sudo apt-get -qq install -y libxml2-utils nmap netcat wireshark tshark vim git gawk htop cmake gcc clang llvm rsync wireshark-dev
      sudo apt-get -qq install -y nmap
      sudo apt-get -qq install -y i2pd
      sudo apt-get -qq install -y tor
      sudo apt-get -qq install -y openvpn
      sudo apt-get -qq install -y hashcat
      echo
      echo -e "Done"
      sleep 5
      clear

      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing VIM and Vundle ... \e[0m"
      echo
      echo
      sudo pip3 install asciinema
      sudo apt-get -qq install -y asciinema
      pip3 install mkdocs
      pip3 install click-man
      echo
      echo -e "Done"
      sleep 5
      clear

      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing VIM and Vundle ... \e[0m"
      echo
      echo
      git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
      sh ~/.vim_runtime/install_awesome_vimrc.sh
      git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
      echo
      echo -e "Done"
      sleep 5
      clear

      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing Nvidia... \e[0m"
      echo
      echo
      sudo apt-get -qq install -y nvidia-driver nvidia-cuda-toolkit
      echo
      echo -e "Done"
      pause
      sleep 5
      clear

      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing YouCompleteMe ... \e[0m"
      echo
      echo
      sudo apt install build-essential cmake vim-nox python3-dev
      sudo apt install
      cd ~/.vim/bundle/
      git clone https://github.com/tabnine/YouCompleteMe.git
      cd YouCompleteMe
      python3 install.py --all
      echo
      echo -e "Done"
      sleep 5
      clear


      #    echo
      #    echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing Ruby... \e[0m"
      #    echo
      #    echo
      #sudo apt-add-repository -y ppa:brightbox/ruby-ng
      #gem install bundler
      #\curl -sSL https://get.rvm.io | bash -s -- --autolibs=install-packages
      #sudo .rvm/bin/rvm requirements
      #\curl -sSL https://get.rvm.io | bash -s stable --ruby
      #rvm install "ruby-2.7.2"


      echo
      echo -e "\e[40;38;5;82m [-] \e[30;48;5;82m Installing Go... \e[0m"
      echo
      echo
      wget -q https://storage.googleapis.com/golang/getgo/installer_linux
      chmod +x installer_linux
      ./installer_linux
      #sudo apt install go
      echo
      echo -e "Done"
      sleep 5
      clear
      # Add key and repo for MongoDB (4.0)
      #wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc |  sudo apt-key add -
      #sudo sh -c "cat <<EOT > /etc/sudo apt/sources.list.d/mongodb-org-4.0.list
      #deb http://repo.mongodb.org/sudo apt/ubuntu $(lsb_release -c | awk '{print $2}')/mongodb-org/4.0 multiverse
      #EOT"
      #sudo apt-get update

      #sudo apt-get install -y crudini
      #sudo apt-get install -y mongodb-org
      #sudo apt-get install -y rabbitmq-server
      #sudo systemctl enable mongod
      #sudo systemctl start mongod
      #Install Comp HERE ---
      #Microsoft
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing .Net - Windows Binaries  \e[0m"
      echo
      echo
      echo "wget https://packages.microsoft.com/config/ubuntu/$ubver/packages-microsoft-prod.deb"
      echo
      pause
      echo
      wget https://packages.microsoft.com/config/ubuntu/$ubver/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
      sudo dpkg -i packages-microsoft-prod.deb
      sudo apt update
      sudo apt-get -qq install -y apt-transport-https
      sudo apt update
      sudo apt-get -qq install -y dotnet-sdk-5.0
      sudo apt-get -qq install -y aspnetcore-runtime-5.0
      sudo apt-get -qq install -y dotnet-sdk-3.1
      sudo apt-get -qq install -y aspnetcore-runtime-3.1
      sudo apt-get -qq install -y dotnet-runtime-3.1
      echo
      echo -e "Done"
      sleep 5
      clear

      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Metasploit , Venom , Searchsploit  \e[0m"
      echo
      curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
        chmod 755 msfinstall && \
        ./msfinstall
      sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
      sudo ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
      echo
      echo -e "Done"
      sleep 5
      clear

      #Nmap Scripts
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Metasploit , Venom , Searchsploit  \e[0m"
      echo
      git clone https://github.com/scipag/vulscan scipag_vulscan
      sudo ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan
      sudo git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/nmap-vulners
      echo
      echo -e "Done"
      sleep 5
      clear




    }

function show_menus()
  {
  clear
  echo -e "Setup My New UBuntu Latop Laptop "
  echo
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'a' for !!! Setup Users !!! \e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'b' for Install deps and Software on Laptop !!!\e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'x' for Exit!!!\e[0m"
  echo
  echo "Pick Option:"
  }


  show_menus

  read choice
  if [ "$choice" == a ]; then
      users-s
      show_menus
      read choice
  fi

  if [ "$choice" == b ]; then
      setup-Laptop
      show_menus
      read choice
  fi

  if [ "$choice" == x ]; then
      clear
          sudo apt -qq  autoremove # Check System for package errors
      sleep 2
	  echo
      echo -e "\e[40;38;5;82m [exit] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [exit] \e[30;48;5;82m Have a nice day! \e[0m"
      sleep 2
      echo
  fi


####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script
