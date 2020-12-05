set -ex

case "$1" in                                                                                                                                                                                                                            
    install)
	sudo bash scripts/install.sh install
	sudo cp dnsmasq.conf /etc
	sudo cp interfaces /etc/network
	sudo cp hostapd.conf /etc/hostapd
	sudo cp hostapd /etc/default
	sudo cp sysctl.conf /etc
	sudo systemctl stop dnsmasq
	sudo systemctl unmask hostapd
	sudo systemctl enable hostapd
	sudo iptables -t nat -A POSTROUTING -j MASQUERADE
	sudo iptables -A FORWARD -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i wlan0 -j ACCEPT
	sudo iptables-save > /etc/iptables/rules.v4
	;;

    delete)
	sudo apt-get remove -y hostapd dnsmasq
	#rm -rf $APPDIR
	;;
esac  
