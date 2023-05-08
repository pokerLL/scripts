#!/bin/sh
echo "================START==================="
echo $#
if [ $# != 2 ];then
	echo "需要传入容器名和端口号两个参数"
	exit 0
fi
cname=$1
dir=/home/docker/${cname}
port=$2
echo $cname  -->  $dir  -->  $port
docker stop $cname
sudo rm -rf $dir
docker rm -f $cname
sudo mkdir -p $dir
sudo chown -R 1000:1000 $dir

# 2.4.5版本之前
# docker run -d --name siyuan -v siyuan:/siyuan -p 6806:6806 b3log/siyuan:v2.4.5 -resident -workspace /siyuan -accessAuthCode 9699
# 2.4.12版本之前
docker run -d --restart=always --name $cname -v $dir:$dir -p $port:6806  -u 1000:1000 b3log/siyuan -workspace $dir

unset dir
unset cname
unset port

echo "================DONE==================="
