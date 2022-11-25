########################
### sudoers.d setup  ###
########################
sudo touch /etc/sudoers.d/devusr
sudo visudo --file=/etc/sudoers.d/devusr
devusr ALL=(ALL) NOPASSWD:ALL
# or
sudo echo "devusr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/devusr


##################
### Ubuntu UFW ###
##################
sudo ufw allow from 10.0.0.0/8 to any port 9001
sudo ufw allow from 10.0.0.0/8 to any port 1234


