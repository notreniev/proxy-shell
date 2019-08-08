#!/bin/bash

# This shell script provides rapid proxy and 
# npm config settings via command line to 
# work deal with npm downloads.
# Example usage: 
#   ./proxy.sh ./.proxy.sh user:password@proxy.mycompany.com:9999
#
# Feel free to contribute
# author: Everton Canez | notreniev@github.com

unproxy(){
    clear
    echo "--unproxy" $1
    # unset previously variables before set them again to avoid to mess up anything
    unset HTTP_PROXY
    unset HTTPS_PROXY
    npm config rm https-proxy
    npm config rm proxy

    tput setaf 4
    echo "**** PROXY and NPM environment settings succesfully unsetted."
    echo " "
    tput setaf 2
}

help(){
    clear
    echo "--help"
    echo " "
    tput setaf 1
    echo "   ** You must pass an argument like this: "
    tput setaf 4
    echo "      usage: proxy.sh user:password@proxy.mycompany.com:9999" 
    echo " "
    echo "      ./proxy.sh -help"                                              # show command line options
    echo "      ./proxy.sh -"                                                  # alias for --help option
    echo "      ./proxy.sh --install"                                          # for install file on $HOME/.bin
    echo "      ./proxy.sh -i"                                                 # alias for --install option
    echo "      ./proxy.sh --unproxy"                                          # for install file on $HOME/.bin
    echo "      ./proxy.sh -u"                                                 # alias for --unproxy option
    echo "      ./proxy.sh --run user:password@proxy.mycompany.com:9999"       # set environment variables 
    echo "      ./proxy.sh user:password@proxy.mycompany.com:9999"             # set environment variables withouy --run option
    tput setaf 2
}

install(){
    clear
    echo "--install"
        # verificar se está no diretório do projeto que contém os scripts
        # para só então rodar o install

    if [ -d "$HOME/.bin" ]; then
        read -p "Would you like to install files on $HOME/.bin' ? [Y/n]" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]];
        then
            rm -rf $HOME/.bin
            mkdir $HOME/.bin
            cp proxy.sh $HOME/.bin/proxy.sh
            chmod +x $HOME/.bin/*
            export PATH="$PATH:$HOME/.bin/proxy.sh"
            tput setaf 4
            echo "File installed on home user" $HOME
            echo " "
            
            HAS_PATH="$(cat ~/.bash_profile | grep ".bin/")"
            EXPORTED=${#HAS_PATH}

            if [ $EXPORTED == 0 ]; then
                export PATH="$HOME/.bin/:$PATH"
                echo 'export PATH="$HOME/.bin/:$PATH"' >>~/.bash_profile
            fi
            echo env | grep "$HOME/.bin/proxy.sh"
            tput setaf 2
        else
            exit
        fi 
    fi
}

run(){
    clear
    if [ $1 ] || [ $2 ]; then
        
        echo arguments: $@
        url=""

        # arguments
        if [ $1 == "--run" ];then
            if [ ! $2 ]; then
                echo "Inform de proxy url (user:password@proxy.mycompany.com:9999)"
                read url
            else
                url=$2
            fi
        else
            url=$1;
        fi

        echo " "
        tput setaf 4
        echo "**** Proxy URL:"
        tput setaf 3
        echo "****" $url;
        echo " "
        tput setaf 2

        if [ $url ]; then
            set variables for a new proxy session
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
            OUTPUT="$(env | grep "PROXY")"
            echo "${OUTPUT}"
            echo " "

            tput setaf 4
            echo "**** NPM environment settings ok."
            
            tput setaf 3
            OUTPUT="$(npm config get | grep "proxy")"
            echo "${OUTPUT}"
            
            tput setaf 2
            echo " "
        else
            echo "No proxy URL informed "
            echo " "
            help 
        fi
    else
        help 
    fi
}

case $1 in
    --unproxy) unproxy $1 ;;
    -u) unproxy $1 ;;
    --help) help $1 ;;
    -h) help $1 ;;
    --install) install $1 ;;
    -i) install $1 ;;
    --run) run $1 $2 ;;
    *) run $1 $2;;
esac
