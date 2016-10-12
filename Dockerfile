FROM benyoo/alpine:openjdk-8-jre-20161012
MAINTAINER from www.dwhd.org by lookback (mondeolove@gmail.com)

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.9

LABEL name="zookeeper" version=$VERSION

ENV INSTALL_DIR=/opt/zookeeper \
	TEMP_DIR=/tmp/zookeeper

RUN set -x && \
	apk add --no-cache bash && \
	mkdir -p ${INSTALL_DIR} ${TEMP_DIR} && \
	curl -Lk $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz|tar xz -C /opt/zookeeper --strip-components=1 && \
	cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \

EXPOSE 2181 2888 3888

WORKDIR ${INSTALL_DIR}

VOLUME ["${INSTALL_DIR}/conf", "${TEMP_DIR}"]

ENTRYPOINT ["${INSTALL_DIR}/bin/zkServer.sh"]
CMD ["start-foreground"]
