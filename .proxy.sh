#!/bin/bash

# This shell script provides rapid proxy and 
# npm config settings via command line to 
# work deal with npm downloads.
# Example usage: 
#   ./proxy.sh ./.proxy.sh user:password@proxy.mycompany.com:9999

if [ $1 == "--help" ]; then
    echo "   ==> source ./.proxy.sh username password proxy-url proxy-port" 
else
    tput setaf 2
    if [ ! $1 ]; then
        clear
        tput setaf 1
        echo "**** You must be pass an argument like this, ex.: "
        tput setaf 3
        echo "   ==> ./proxy.sh ./.proxy.sh user:password@proxy.mycompany.com:9999" 
        tput setaf 2
    else
        # arguments
        url=$1;

        tput setaf 2
        echo Proxy URL:
        echo $url;

        # unset variables before set them again
        source ./.unproxy.sh

        # set variables for a new proxy session
        export HTTP_PROXY=http://$url
        export HTTPS_PROXY=https://$url
        export IONIC_HTTP_PROXY=http://$url
        npm config set https-proxy http://$url
        npm config set proxy http://$url
        npm config set strict-ssl false

        clear
        tput setaf 4
        echo "**** Proxy environment settings ok."
        tput setaf 3
        env | grep "PROXY"

        tput setaf 4
        echo "**** NPM environment settings ok."
        tput setaf 3
        npm config get | grep "proxy"
        tput setaf 2
    fi
fi
