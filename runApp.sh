ID=$(git rev-parse --short HEAD)
echo "构建镜像ID： $ID"
INAME=Ranxfan/shadowsocks-$ID
echo "构建镜像名： $INAME"
NAME=shadowsocks
echo "启动容器名： $NAME"

port=10010
pass=nba123
m=chacha20

start(){
  images=$(docker images -q $INAME)  #检查是否构建成功
  if [ $images ];then
    container=$(docker ps -a -f name=$NAME -q)
    if [ $container ];then
      echo "删除旧容器"
      docker rm -f $container
    fi     #ifend
    echo "启动容器 $NAME"
    docker run --name="$NAME" \
      --restart always \
      -p "$port":"$port" \
      -d $INAME -s 0.0.0.0 -p $port -k $pass -m $m
  fi     #ifend
}

images=$(docker images -q $INAME)
if [ $images ];then
  echo "镜像已存在"
else
  echo "开始构建镜像"
  docker build -t $INAME . #构建镜像
fi     #ifend

start



