case "$1" in                                                                                                                                                                                                                            
  install)                                                                                                                                                                                                                            
    sudo apt-get update                                                                                                                                                                                                             
    sudo apt-get upgrade -y                                                                                                                                                                                                         
    sudo apt-get install -y hostapd dnsmasq
    sudo systemctl stop hostapd
    sudo systemctl stop dnsmasq    
    sudo cp dnsmasq.conf /etc
    sudo cp                                                                                                                                                                                          
    ;;                                                                                                                                                                                                                              
  delete)                                                                                                                                                                                                                             
    sudo apt-get remove -y                                                                                                                                                                                                          
    hostapd dnsmasq                                                                                                                                                                                                                 
    rm -rf $APPDIR                                                                                                                                                                                                                  
    ;;                                                                                                                                                                                                                              
esac  