#!/bin/sh

proxyset=$http_proxy
proxy="proxy.yoursite.com"
port="3128"
username="youruser"
password="yourpass"

setproxy() {
	setenv
	setfile
}

setenv() {
	if [ -n "$username" ]
	then
		proxy="http://$proxy:$port/"
	else
		proxy="http://$username:$password@$proxy:$port/"
	fi

	export http_proxy=$proxy
	export HTTP_PROXY=$proxy
	export https_proxy=$proxy
	export HTTPS_PROXY=$proxy
	export ftp_proxy=$proxy
	export FTP_PROXY=$proxy
	export all_proxy=$proxy
	export ALL_PROXY=$proxy

	echo "proxy added"
}

setfile() {
	echo "Acquire::http::proxy \"$proxy\";\nAcquire::ftp::proxy \"$proxy\";\nAcquire::https::proxy \"$proxy\";" | sudo tee /etc/apt/apt.conf.d/95proxies
}

removeproxy() {
	removeenv
	removefile

	echo "proxy removed"
}

removeenv() {
	unset HTTP_PROXY
	unset http_proxy
	unset HTTPS_PROXY
	unset https_proxy
	unset ftp_proxy
	unset FTP_PROXY
	unset all_proxy
	unset ALL_PROXY
}

removefile() {
	sudo bash -c "rm /etc/apt/apt.conf.d/95proxies"
	sudo bash -c "rm /etc/apt/apt.conf.d/95Proxies"
}

if [ -n "$proxyset" ];
then
	removeproxy
else
	setproxy
fi

exit 0
