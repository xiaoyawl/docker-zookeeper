#docker-zookeeper

[![](https://images.microbadger.com/badges/version/benyoo/zookeeper.svg)](https://microbadger.com/images/benyoo/zookeeper "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/benyoo/zookeeper.svg)](https://microbadger.com/images/benyoo/zookeeper "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/benyoo/zookeeper.svg?maxAge=2592000)](https://hub.docker.com/r/benyoo/zookeeper/) [![Docker Automated buil](https://img.shields.io/docker/automated/benyoo/zookeeper.svg?maxAge=2592000)](https://hub.docker.com/r/benyoo/zookeeper/)

Builds a docker image for Zookeeper.

```bash
docker build -t benyoo/zookeeper:3.4.9 github.com/xiaoyawl/docker-zookeeper
```

### Start an instance for cluster Node1:
```bash
docker run -d --name=zookeeper --net=host --restart=always \
-e MYID=1 -e SERVERS=node1,node2,node3,node4,node5 \
benyoo/zookeeper:3.4.9
```

### Start an instance for cluster Node2:
```bash
docker run -d --name=zookeeper --net=host --restart=always \
-e MYID=2 -e SERVERS=node1,node2,node3,node4,node5 \
benyoo/zookeeper:3.4.9
```


