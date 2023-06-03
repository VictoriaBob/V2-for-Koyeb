FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl &&\
    wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/download/v5.7.0/v2ray-linux-64.zip &&\
    unzip temp.zip v2ray geoip.dat geosite.dat &&\
    mv v2ray v &&\
    rm -f temp.zip &&\
    chmod -v 755 v entrypoint.sh &&\
    echo 'ewoJImxvZyI6IHsKCQkiYWNjZXNzIjogIi9kZXYvbn\
VsbCIsCgkJImVycm9yIjogIi9kZXYvbnVsbCIsCgkJ\
ImxvZ2xldmVsIjogIndhcm5pbmciCgl9LAoJImluYm\
91bmRzIjogW3sKCQkJInBvcnQiOiAxMDAwMCwKCQkJ\
Imxpc3RlbiI6ICIxMjcuMC4wLjEiLAoJCQkicHJvdG\
9jb2wiOiAidm1lc3MiLAoJCQkic2V0dGluZ3MiOiB7\
CgkJCQkiY2xpZW50cyI6IFt7CgkJCQkJImlkIjogIl\
VVSUQiLAoJCQkJCSJhbHRlcklkIjogMAoJCQkJfV0K\
CQkJfSwKCQkJInN0cmVhbVNldHRpbmdzIjogewoJCQ\
kJIm5ldHdvcmsiOiAid3MiLAoJCQkJIndzU2V0dGlu\
Z3MiOiB7CgkJCQkJInBhdGgiOiAiVk1FU1NfV1NQQV\
RIIgoJCQkJfQoJCQl9CgkJfQoJXSwKCSJvdXRib3Vu\
ZHMiOiBbewoJCSJwcm90b2NvbCI6ICJmcmVlZG9tIi\
wKCQkic2V0dGluZ3MiOiB7fQoJfV0sCgkiZG5zIjog\
ewoJCSJzZXJ2ZXIiOiBbCgkJCSI4LjguOC44IiwKCQ\
kJIjguOC40LjQiLAoJCQkibG9jYWxob3N0IgoJCV0K\
CX0KfQo=' > config

ENTRYPOINT [ "./entrypoint.sh" ]
