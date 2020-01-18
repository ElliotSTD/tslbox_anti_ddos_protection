#Powered by tslbox.com

#iptables initiate#
iptables -t filter -X specialips 2>/dev/null
iptables -t filter -N specialips

#iptables -F#

iptables -A FORWARD -j DROP
iptables -A OUTPUT -j ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport http -j ACCEPT
iptables -A INPUT -p tcp --dport https -j ACCEPT

#iptables specialips#

iptables -N specialips
iptables -A specialips -s 192.168.0.107 -j RETURN #trusted ip address#
iptables -A specialips -j DROP

iptables -A INPUT -j specialips
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -j DROP

iptables-save > /etc/iptables.rules
