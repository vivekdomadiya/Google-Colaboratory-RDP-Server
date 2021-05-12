#! /bin/bash
# Get Data
printf "Please insert username and the password for the server\n"
read -p "Username: " USRNM
read -p "Password: " PSWD
printf '\nPlease insert 6 digits pin\n'
read -p "Pin": PIN
printf '\nPlease check https://remotedesktop.google.com/headless And copy the command line of Debian Linux and then paste it\n'
read -p "Command: " CRP

# Add User
printf "\nCreating User..." >&2
{
  sudo useradd -m """$USRNM"""
  sudo adduser """$USRNM""" sudo
  echo """$USRNM:$PSWD""" | sudo chpasswd
  sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
} &> /dev/null && 
printf "\nUser Created\n" >&2 || 
printf "\nAn error has occured" >&2

# Update Server
printf "\nUpdating Server" >&2
{
  sudo apt update
  sudo apt-get upgrade
} &> /dev/null && 
printf "\nPackage upgrade has completed.\n" >&2 || 
printf "\nAn error has occured while updating Server\n" >&2

# Insrall CRD
printf "\nInstalling Chrome Remote Desktop" >&2
{
  wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
  sudo dpkg --install chrome-remote-desktop_current_amd64.deb
  sudo apt install --assume-yes --fix-broken
} &> /dev/null && 
printf "\nChrome Remote Desktop Installed successfully\n" >&2 || 
printf "\nAn error has occured\n" >&2

# Installing Desktop Environment
printf "\nInstalling Desktop Environment" >&2
{
  sudo DEBIAN_FRONTEND=noninteractive \
  apt install --assume-yes xfce4 desktop-base
  sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
  sudo apt remove --assume-yes gnome-terminal
  sudo apt install --assume-yes xscreensaver
  sudo systemctl disable lightdm.service
} &> /dev/null && 
printf "\nDesktop Environment Installed successfully\n" >&2 || 
printf "\nAn error has occured\n" >&2

# Installing Google Chrome
printf "\nInstalling Google Chrome" >&2
{
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --install google-chrome-stable_current_amd64.deb
  sudo apt install --assume-yes --fix-broken
} &> /dev/null && 
printf "\nGoogle Chrome Installed successfully\n" >&2 || 
printf "\nAn error has occured\n" >&2

# Finalizing
printf "\nFinalizing" >&2
{
  sudo adduser """$USRNM""" chrome-remote-desktop
  su - """$USRNM""" -c """$CRP --pin=$PIN"""
  sudo service chrome-remote-desktop start
} &> /dev/null &&
printf "\nSetup has completed " >&2 ||
printf "\nAn error has occured " >&2

# Finish
printf '\n\nPlease check https://remotedesktop.google.com/access/ \n'
