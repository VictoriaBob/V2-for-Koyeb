#!/usr/bin/env bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
base64 -d config > config.json
UUID=${UUID:-'de04add9-5c68-8bab-950c-08cd5320df18'}
VLESS_XHTTPPATH=${VLESS_XHTTPPATH:-'/path4xhttp'}
VLESS_WSPATH=${VLESS_WSPATH:-'/path4ws'}
sed -i "s#UUID#$UUID#g;s#VLESS_XHTTPPATH#${VLESS_XHTTPPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" config.json
sed -i "s#VLESS_XHTTPPATH#${VLESS_XHTTPPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" /etc/nginx/nginx.conf

# 伪装 xray 执行文件
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv v ${RELEASE_RANDOMNESS}
cat config.json | base64 > config
rm -f config.json

# 运行 nginx 和 xray
nginx
base64 -d config > config.json
./${RELEASE_RANDOMNESS} run
