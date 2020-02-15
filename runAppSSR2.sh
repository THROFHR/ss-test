INAME=lnterface/ssr-with-net_speeder
NAME=ssr
echo "启动容器名： $NAME"

# ss01='10001,nba123,none'
ss02='12002,nba123,table'
ss03='12003,nba123,rc4'
ss04='12004,nba123,rc4-md5-6'
ss05='12005,nba123,rc4-md5'
ss06='12006,nba123,aes-128-cfb'
ss07='12007,nba123,aes-192-cfb'
ss08='12008,nba123,aes-256-cfb'
ss09='12009,nba123,aes-128-ctr'
ss10='12010,nba123,aes-192-ctr'
ss11='12011,nba123,aes-256-ctr'
ss12='12012,nba123,aes-128-gcm'
ss13='12013,nba123,aes-192-gcm'
ss14='12014,nba123,aes-256-gcm'
ss15='12015,nba123,camellia-128-cfb'
ss16='12016,nba123,camellia-192-cfb'
ss17='12017,nba123,camellia-256-cfb'
ss18='12018,nba123,bf-cfb'
ss19='12019,nba123,cast5-cfb'
ss20='12020,nba123,des-cfb'
ss21='12021,nba123,idea-cfb'
ss22='12022,nba123,rc2-cfb'
ss23='12023,nba123,seed-cfb'
ss24='12024,nba123,salsa20'
ss25='12025,nba123,chacha20'
ss26='12026,nba123,chacha20-ietf'
ss27='12027,nba123,chacha20-poly1305'
ss28='12028,nba123,chacha20-ietf-poly1305'
ss29='12029,nba123,xchacha20'
ss30='12032,nba123,xchacha20-ietf-poly1305'
# 端口 密码 加密方法

all="$ss01;$ss02;$ss03;$ss04;$ss05;$ss06;$ss07;$ss08;$ss09;$ss10;$ss11;$ss12;$ss13;$ss14;$ss15;$ss16;$ss17;$ss18;$ss19;$ss20;$ss21;$ss22;$ss23;$ss24;$ss25;$ss26;$ss27;$ss28;$ss29;$ss30;$ss31;$ss32"

satrtParam(){
  port=$1
  pass=$2
  m=$3
  name=${NAME}-${port}-${pass}-${m}
  echo "端口：${port} 密码：${pass} 加密方法：${m} 启动: python shadowsocks/server.py -s 0.0.0.0 -p $port -k $pass -m $m  -o plain -O origin"
  
  container=$(docker ps -a -f name=$name -q)
    if [ $container ];then
      echo "删除旧容器"
      docker rm -f $container
    fi     #ifend
    echo "启动容器 $name"
    docker run --name="$name" \
      --restart always \
      -p "$port":"$port" \
      -d $INAME -s 0.0.0.0 -p $port -k $pass -m $m -o plain -O origin
}




build(){
  images=$(docker images -q $INAME)
  if [ $images ];then
    echo "镜像已存在"
  else
    echo "开始构建镜像"
    docker pull $INAME  #构建镜像
  fi     #ifend
}


start(){
  list=(${all//;/ })
  for var in ${list[@]}
  do
    if [ $var ];then
      string="$var"
      array=(${string//,/ })
      echo "-s 106.53.42.13 -p ${array[0]} -k ${array[1]} -m ${array[2]}"
      satrtParam ${array[0]} ${array[1]} ${array[2]}
    fi     #ifend
  done 
}
build
start

# docker run -d --name=docker-ssr -p 10086:10086 --restart=always lnterface/ssr-with-net_speeder -s 0.0.0.0 -p 10086 -k nba123 -m aes-256-cfb -o plain -O origin
# docker run -d --name=docker-ssr -p 10086:10086 --restart=always lnterface/ssr-with-net_speeder -s 0.0.0.0 -p 10086 -k nba123 -m aes-256-cfb -o plain -O origin


