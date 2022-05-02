#!/bin/bash
# SCRIPT:to setup nfs filesystem
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: NFS Share
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
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    exit 1
fi

clear

function pause(){
        local message="$@"
        [ -z $message ] && message="Press [Enter] key to continue..."
        read -p "$message" readEnterKey
}

function users-s()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will setup your sudo user - HE we will be  used for NFS Share MAINT   \e[0m"
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


function install-sestup()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will INSTALL the NFS Software - Server SIDE \e[0m"
    echo
    echo
        sleep 5
    echo
    echo -e "IT's \e[5mRUNNING IN SILENT MODE !!! \e[25mErorrs will show."
    echo
    apt-get -qq update # apt update silent
    apt-get -qq upgrade  # apt ugrade silent
        apt-get -qq install nfs-kernel-server aptitude nfs-utils nfs-common
    echo
	echo
    apt search  nfs-kernel-server*
    echo
        sleep 5
        pause
        echo
    echo -e "Done"
    clear

  }

function install-cestup()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will INSTALL the NFS Software - Client SIDE \e[0m"
    echo
    echo
        sleep 5
    echo
    echo -e "IT's \e[5mRUNNING IN SILENT MODE !!! \e[25mErorrs will show."
    echo
    apt-get -qq update # apt update silent
    apt-get -qq upgrade  # apt ugrade silent
        apt-get -qq install nfs-kernel-server aptitude nfs-utils nfs-common
    echo
	echo
    apt search  nfs-kernel-server*
    echo
        sleep 5
        pause
        echo
    echo -e "Done"
    clear

  }



function nfs-sestup()
{
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will Setup the NFS Share   \e[0m"
    echo
    echo
    echo -e "This Will Setup and Config your share "
    echo
        pause
        echo "SetUp NFS Share of Users Home"
    echo
    echo -e "What user should we setup as NFS Share for ?"
    read huss
    echo
    echo
    mkdir -p /srv/nfs4/$huss
    echo
        mount --bind /home/$huss /srv/nfs4/$huss # Binds User home to a share
    echo
        clear
        echo
        echo -e "\e[40;38;5;3m [??] \e[30;48;5;82m Are you Happy WITH YOUR Config ?  \e[0m"
        echo
        echo
        echo "Config - This will be appended to fstab :"
        echo
        echo "/home/$huss  /srv/nfs4/$huss none   bind   0   0"
        echo
		pause
		echo "/home/$huss  /srv/nfs4/$huss none   bind   0   0" >> /etc/fstab
		echo
		echo "FSTAB Entry : /ect/fstab"
		echo
		cat /etc/fstab
		echo
        pause
		echo
        clear
        echo
		echo "Creating host export file"
		echo
		echo "/srv/nfs4         0.0.0.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)" >> /etc/exports
		echo "/srv/nfs4/$huss 0.0.0.0/24(ro,sync,no_subtree_check) 0.0.0.0(rw,sync,no_subtree_check)" >> /etc/exports
		echo "/srv/nfs4         192.168.1.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)" >> /etc/exports
		echo "/srv/nfs4/$huss 192.168.1.0/24(ro,sync,no_subtree_check) 192.168.1.0/24(rw,sync,no_subtree_check)" >> /etc/exports
		echo
		echo "Export File Entry : /etc/exports"
		echo
		cat  /etc/exports
		echo
		exportfs -ar
		echo
		clear
		echo
		echo "NFS Config"
		echo
		exportfs -v
		echo
		pause
		clear
		echo
		echo "Change to Firewall:"
		echo
		ufw allow from 192.168.1.0/24 to any port nfs
		ufw allow from 0.0.0.0/24 to any port nfs
		echo
		ufw status
		echo
		pause
    echo -e "Done"
    clear

  }


function show_menus()
  {
  echo -e "\e[40;38;5;9m [+] \e[30;48;5;82m  NFS Share Setup For Ubuntu   \e[0m"
  echo
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'a' for !!! Setup NFS SUDO  User * FOR MAINT !!! \e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'b' for Install deps and Software For NFS Share  !!!\e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'c' for Configure NFS Share as USERS Home  !!!\e[0m"
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

  if [ "$choice" == c ]; then
      nfs-sestup
      show_menus
      read choice
  fi

  if [ "$choice" == x ]; then
      clear
          apt -qq  autoremove # Check System for package errors
      sleep 2
	  echo
      echo -e "\e[40;38;5;82m [exit] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [exit] \e[30;48;5;82m Have a nice day! \e[0m"
      sleep 2
      echo
      exit 0
  fi




####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script
