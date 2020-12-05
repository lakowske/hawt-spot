case "$1" in                                                                                                                                                                                                                            
  install)                                                                                                                                                                                                                            
    sudo apt-get update                                                                                                                                                                                                             
    sudo apt-get upgrade -y                                                                                                                                                                                                         
    sudo apt-get install -y hostapd dnsmasq iptables iptables-persistent bridge-utils

    ;;                                                                                                                                                                                                                              
  delete)                                                                                                                                                                                                                             
    sudo apt-get remove -y                                                                                                                                                                                                          
    hostapd dnsmasq                                                                                                                                                                                                                 
    rm -rf $APPDIR                                                                                                                                                                                                                  
    ;;                                                                                                                                                                                                                              
esac  
