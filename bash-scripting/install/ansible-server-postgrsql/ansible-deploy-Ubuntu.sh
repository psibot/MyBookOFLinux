#!/bin/bash
# SCRIPT:
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: Ansible AWX Deployment Ubuntu 
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################

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

function deploy-ansible-ubuntu()
{   
    clear
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Needed Comps for Ansible AWX!!!  \e[0m"
    echo
    echo "Installing system"
    echo
    # install needed software.
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    touch /etc/apt/sources.list.d/kubernetes.list 
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list 
    apt update
    apt install docker.io kubelet kubeadm kubectl kubernetes-cni -y
    apt install python-setuptools python3-pip -y
    pip3 install ansible 
    apt install docker curl apt-transport-https virtualbox virtualbox-ext-pack  -y
    pip3 install docker-compose
    systemctl enable docker &&  systemctl start docker
    systemctl enable kubelet &&  systemctl start kubelet
    apt install git vim pwgen -y
    apt install python3.8-venv -y
    pip3 install awxkit
    pip3 install sphinx sphinxcontrib-autoprogram
    rm -fr awx*
    git clone https://github.com/ansible/awx.git
    git clone https://github.com/ansible/awx-operator.git
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    cp minikube-linux-amd64 /usr/local/bin/minikube
    chmod 755 /usr/local/bin/minikube
    clear 
    sleep 3
    minikube version
    sleep 3


  }

function setup-user-ansible()
  {
      clear
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m This Will setup your user for Ansile  \e[0m"
      echo
      echo "SetUp User "
      echo
      echo -e "What user should we setup for sudo - type the username"
      read uss 
      echo 
      adduser $uss 
      echo "$uss ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$uss
      sudo chmod 0440 /etc/sudoers.d/$uss
      usermod -aG docker $uss
      echo 
      echo -e "Done"
      sleep 3
    }

function show_menus()
  {
  echo
  echo -e "Ansible AWX Setup and Deployment Script - Ubuntu "
  echo 
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'a' for !!! Install Comps For Ansible  !!! \e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'b' for !!! Setup user for Ansible !!!\e[0m"
  echo -e "\e[32m[-]\e[0m \e[1m   Choose : Hit 'x' for Exit!!!\e[0m"
  echo
  echo "Pick Option:"
  }


  show_menus

  read choice
  if [ "$choice" == a ]; then
      deploy-ansible-ubuntu
      clear
      show_menus
      read choice
  fi

  if [ "$choice" == b ]; then
      setup-user-ansible
      clear
      show_menus
      read choice
  fi


  if [ "$choice" == x ]; then
      clear
      sleep 3
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
      exit 0
  fi


####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script

