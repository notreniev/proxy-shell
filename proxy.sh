#!/bin/bash

# This shell script provides rapid proxy and 
# npm config settings via command line to 
# work deal with npm downloads.
# Example usage: 
#   ./proxy.sh ./.proxy.sh user:password@proxy.mycompany.com:9999

if [ $1 == "--unproxy" ] || [ $1 == "-u" ]; then
    ./$HOME/.unproxy.sh
fi

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    tput setaf 4
    echo " "
    echo "      usage: ./.proxy.sh user:password@proxy.mycompany.com:9999" 
    echo " "
    tput setaf 2
else
    if [ ! $1 ]; then
        tput setaf 2
        clear
        tput setaf 1
        echo "**** You must be pass an argument like this, ex.: "
        tput setaf 3
        echo "      ./.proxy.sh user:password@proxy.mycompany.com:9999" 
        echo " "
        tput setaf 2
    else
        clear

        # unset previously variables before set them again to avoid to mess up anything
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset IONIC_HTTP_PROXY

        npm config rm https-proxy
        npm config rm proxy

        tput setaf 4
        echo "**** PROXY and NPM environment settings succesfully unsetted."
        echo " "
        tput setaf 2

        # arguments
        url=$1;

        tput setaf 2
        echo Proxy URL:
        echo $url;
        echo " "

        # set variables for a new proxy session
        export HTTP_PROXY=http://$url
        export HTTPS_PROXY=https://$url
        export IONIC_HTTP_PROXY=http://$url
        npm config set https-proxy http://$url
        npm config set proxy http://$url
        npm config set strict-ssl false

        #clear
        tput setaf 4
        echo "**** Proxy environment settings ok."
        
        tput setaf 3
        env | grep "PROXY"
        echo " "

        tput setaf 4
        echo "**** NPM environment settings ok."
        
        tput setaf 3
        npm config get | grep "proxy"
        tput setaf 2
        echo " "
    fi
fi

if [ ! -f $HOME/".proxy.sh" ] && [ ! -f $HOME/".unproxy.sh" ]; then
    read -p "Would you like to install file on home user $HOME ? [Y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]];
    then
        mkdir $HOME/bin
        cp proxy.sh $HOME/bin
        cp unproxy.sh $HOME/bin
        chmod +x $HOME/bin/*
        export PATH="$PATH:$HOME/bin"
        tput setaf 4
        echo "Arquivo instalado na raíz do diretório do usuário"
        tput setaf 2
    else
        exit
    fi 
fi
