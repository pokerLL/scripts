function proxy_on(){
    export ALL_PROXY=socks5://127.0.0.1:20170
    export http_proxy=http://127.0.0.1:20171
    export https_proxy=http://127.0.0.1:20171
    echo -e "Enabled proxy..."
}

function proxy_off(){
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    echo -e "Disabled proxy..."
}

