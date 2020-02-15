ID=$(git rev-parse --short HEAD)
echo "构建镜像ID： $ID"
INAME=ranxfan/shadowsocks-$ID
echo "构建镜像名： $INAME"
NAME=shadowsocks
echo "启动容器名： $NAME"

ss01='10001,nba123,none'
ss02='10002,nba123,table'
ss03='10003,nba123,rc4'
ss04='10004,nba123,rc4-md5-6'
ss05='10005,nba123,rc4-md5'
ss06='10006,nba123,aes-128-cfb'
ss07='10007,nba123,aes-192-cfb'
ss08='10008,nba123,aes-256-cfb'
ss09='10009,nba123,aes-128-ctr'
ss10='10010,nba123,aes-192-ctr'
ss11='10011,nba123,aes-256-ctr'
ss12='10012,nba123,aes-128-gcm'
ss13='10013,nba123,aes-192-gcm'
ss14='10014,nba123,aes-256-gcm'
ss15='10015,nba123,camellia-128-cfb'
ss16='10016,nba123,camellia-192-cfb'
ss17='10017,nba123,camellia-256-cfb'
ss18='10018,nba123,bf-cfb'
ss19='10019,nba123,cast5-cfb'
ss20='10020,nba123,des-cfb'
ss21='10021,nba123,idea-cfb'
ss22='10022,nba123,rc2-cfb'
ss23='10023,nba123,seed-cfb'
ss24='10024,nba123,salsa20'
ss25='10025,nba123,chacha20'
ss26='10026,nba123,chacha20-ietf'
ss27='10027,nba123,chacha20-poly1305'
ss28='10028,nba123,chacha20-poly1305-ietf'
ss29='10029,nba123,xchacha20'
ss30='10030,nba123,xchacha20-ietf'
ss32='10032,nba123,xchacha20-poly1305'
ss32='10032,nba123,xchacha20-poly1305-ietf'
# 端口 密码 加密方法


all="$ss01;$ss02;$ss03;$ss04;$ss05;$ss06;$ss07;$ss08;$ss09;$ss10;$ss11;$ss12;$ss13;$ss14;$ss15;$ss16;$ss17;$ss18;$ss19;$ss20;$ss21;$ss22;$ss23;$ss24;$ss25;$ss26;$ss27;$ss28;$ss29;$ss30;$ss32;$ss32"

satrtParam(){
  port=$1
  pass=$2
  m=$3
  name=${NAME}-${port}-${pass}-${m}
  echo "端口：${port} 密码：${pass} 加密方法：${m}"
  # images=$(docker images -q $INAME)  #检查是否构建成功
  # if [ $images ];then
  #   container=$(docker ps -a -f name=$name -q)
  #   if [ $container ];then
  #     echo "删除旧容器"
  #     docker rm -f $container
  #   fi     #ifend
  #   echo "启动容器 $name"
  #   docker run --name="$name" \
  #     --restart always \
  #     -p "$port":"$port" \
  #     -d $INAME -s 0.0.0.0 -p $port -k $pass -m $m
  # fi     #ifend
}


build(){
  images=$(docker images -q $INAME)
  if [ $images ];then
    echo "镜像已存在"
  else
    echo "开始构建镜像"
    docker build -t $INAME . #构建镜像
  fi     #ifend
}

start(){
  list=(${all//;/ })
  for var in ${list[@]}
  do
    string="$var"  
    array=(${string//,/ })
    satrtParam ${array[0]} ${array[1]} ${array[2]}
  done 
}
# build
start



