FROM benyoo/alpine:openjdk-8-jre-20161012
MAINTAINER from www.dwhd.org by lookback (mondeolove@gmail.com)

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.9

LABEL name="zookeeper" version=$VERSION

ENV INSTALL_DIR=/opt/zookeeper \
	TEMP_DIR=/tmp/zookeeper

RUN set -x && \
	apk --update --no-cache upgrade && apk add --no-cache curl bash tar iproute2 && \
	mkdir -p ${INSTALL_DIR} ${TEMP_DIR} && \
	curl -Lk https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 -o /usr/bin/dumb-init && \
	chmod +x /usr/bin/dumb-init && \
	curl -Lk $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz|tar xz -C /opt/zookeeper --strip-components=1 && \
	#cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
	mkdir /etc/sysconfig/clock && \
	echo -e 'ZONE="Asia/Shanghai"\nUTC=false\nARC=false' > /etc/sysconfig/clock && \
	rm -rf /var/cache/apk/*

COPY entrypoint.sh /

ENV PATH /opt/zookeeper/bin:$PATH \
	TERM linux

EXPOSE 2181 2888 3888
WORKDIR ${INSTALL_DIR}
VOLUME ["${INSTALL_DIR}/conf", "${TEMP_DIR}"]

ENTRYPOINT ["/usr/bin/dumb-init","/entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]
