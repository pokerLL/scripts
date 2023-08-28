curl -fsSL https://get.docker.com -o get-docker.sh # 使用官方脚本一键安装
sudo sh get-docker.sh
sudo groupadd docker			# 新建docker组
sudo usermod -aG docker $USER 		# 将当前用户假如docker用户组避免每次使用docker命令都要加上sudo权限
newgrp docker				# 刷新docker组
sudo systemctl start docker   		# 启动Docker
docker version           		# 查看当前版本号，是否启动成功
sudo systemctl enable docker  		# 设置开机自启动
