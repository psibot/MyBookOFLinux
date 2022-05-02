#!/bin/bash
# SCRIPT:
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: Menu and Functions
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################
#nfs-user=deamon
#nfs-hostname=$hostname
#nfs-share-local=/srv/nfs4/home-share/
##########################################################
################ BEGINNING OF MAIN #######################
##########################################################

# Run as root.
if [[ $EUID -ne 0 ]]; then # for system setups
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    exit 1
fi

clear

function pause(){ # Pause enter
        local message="$@"
        [ -z $message ] && message="Press [Enter] key to continue..."
        read -p "$message" readEnterKey
}


function users-sudo() # Setup Sudo without password
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will setup your sudo user    \e[0m"
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
	clear

  }

  function install-setup()
  {
      clear
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will install Software with APT in Silent Mode  \e[0m"
      echo
      echo
          sleep 2
      echo
      echo -e "What  Software Do You want to install ? "
      echo
      read searchapt
      echo
      echo -e "IT's \e[5mRUNNING IN SILENT MODE !!! \e[25mErorrs will show."
      echo
      apt-get -qq update # apt update silent
      apt-get -qq upgrade  # apt ugrade silent
      apt-get -qq install $searchapt # aptitude
      echo
  	  echo  -e "*** \e[5m The Followin Software was installed  !!! \e[25m ***"
      apt search  $searchapt
      echo
          sleep 5
          pause
          echo
      echo -e "Done"
      clear

    }


    function show_menus() #Simple Example of A Menu in Bash
      {
      echo -e "\e[40;38;5;9m [+] \e[30;48;5;82m  Some  Setup For Ubuntu   \e[0m"
      echo
      echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'a' for !!! Setup NFS SUDO  User * FOR MAINT !!! \e[0m"
      echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'b' for Install deps and Software For NFS Share  !!!\e[0m"
      #echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'c' for What ever   !!!\e[0m"
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
          install-sestup
          show_menus
          read choice
      fi

#      if [ "$choice" == c ]; then
#          nfs-sestup
#          show_menus
#          read choice
#      fi

      if [ "$choice" == x ]; then
          clear
              apt -qq  autoremove # Check System for package errors
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
