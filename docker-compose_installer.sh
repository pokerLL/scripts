# 获取最新版本号
latest_version=$(curl -sL https://api.github.com/repos/docker/compose/releases/latest | grep -oP '(?<=tag\/)v\d+\.\d+\.\d+') 
# 获取系统类型和架构
sys_type=$(uname -s | tr '[:upper:]' '[:lower:]')
sys_arch=$(uname -m | tr '[:upper:]' '[:lower:]')
# 构建下载链接
download_url="https://github.com/docker/compose/releases/download/$latest_version/docker-compose-$sys_type-$sys_arch"

echo "docker-compose最新版本号：$latest_version"
echo "docker-compose下载链接：$download_url"


if command -v docker-compose &>/dev/null; then
    read -p "检测到docker-compose已安装: $(docker-compose version),是否更新(y/n)" choice
    if [ "$choice" == 'n' ]; then
        exit 0
    fi 
fi

exit 1

sudo rm -f /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo curl -L $download_url -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
