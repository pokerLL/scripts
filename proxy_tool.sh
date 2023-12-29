export PROXY_HOST=192.168.25.20
export PROXY_SOCKET_PORT=20170
export PROXY_HTTP_PORT=20171
export PROXY_USER=admin
export PROXY_PSD=zxc123

function proxy_on(){
    export ALL_PROXY=socks5://$PROXY_HOST:$PROXY_SOCKET_PORT
    export http_proxy=http://$PROXY_USER:$PROXY_PSD@$PROXY_HOST:$PROXY_HTTP_PORT
    export https_proxy=http://$PROXY_USER:$PROXY_PSD@$PROXY_HOST:$PROXY_HTTP_PORT
    echo -e "Enabled proxy on $PROXY_SOCKET_PORT(socks5) and $PROXY_HTTP_PORT(http)..."
}

function proxy_off(){
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    echo -e "Disabled proxy..."
}

