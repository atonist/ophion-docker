FROM alpine:latest

RUN adduser -D ircd -h /ircd

RUN apk --update add \
  meson alpine-sdk flex bison sqlite sqlite-dev mbedtls mbedtls-dev ninja supervisor \
  && mkdir -p /var/log/supervisor \
  && sed -i '/\[supervisord\]/a nodaemon=true' /etc/supervisord.conf \
  && rm -rf /var/cache/apk/* 

EXPOSE 5000
EXPOSE 6665-6669
EXPOSE 6697
EXPOSE 9999

USER ircd
RUN cd /ircd \
  && git clone https://github.com/ophion-project/ophion.git \
  && cd ophion \
  && meson build --prefix=/ircd \
  && meson install -C build \
  && cd .. \
  && rm -rf ophion  \
  && rm -rf etc 

USER root
ENV PATH=/ircd/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/ircd/lib:/usr/lib:/lib:/usr/local/lib

add supervisor_services.conf /super.conf
RUN cat /super.conf >> /etc/supervisord.conf && rm /super.conf
CMD ["/usr/bin/supervisord"]


