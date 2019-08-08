This is a "pet project" based on necessity to provide fast configuration for proxy and npm config settings via command line to deal with npm downloads.

Put it on the root of your user folder and call it or run -i option to install on yout home user:

Install: 
#   ./proxy.sh -i
#   ./proxy.sh --install

Example usage: 
#      proxy.sh user:password@proxy.mycompany.com:9999

Options: 
#    ./proxy.sh -help                                              # show command line options
#    ./proxy.sh -                                                  # alias for --help option
#    ./proxy.sh --install                                          # for install file on $HOME/.bin
#    ./proxy.sh -i                                                 # alias for --install option
#    ./proxy.sh --unproxy                                          # for install file on $HOME/.bin
#    ./proxy.sh -u                                                 # alias for --unproxy option
#    ./proxy.sh --run user:password@proxy.mycompany.com:9999       # set environment variables 
#    ./proxy.sh user:password@proxy.mycompany.com:9999             # set environment variables withouy --run option

