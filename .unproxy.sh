#!/bin/bash

# Just unset environment and npm settings for
# proxy configuration
# Example usage: 
#   ./unproxy.sh

unset HTTP_PROXY
unset HTTPS_PROXY
unset IONIC_HTTP_PROXY

npm config rm https-proxy
npm config rm proxy
