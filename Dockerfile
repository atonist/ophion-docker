FROM alpine:latest AS builder

RUN set -xe; \
	apk add --no-cache --virtual .build-deps \
		git \
		meson \
		alpine-sdk \
		flex \
		bison \
		sqlite-dev \
		mbedtls-dev \
		zlib-dev \
	\
	&& git clone https://github.com/ophion-project/ophion.git \
	&& cd /ophion \
	&& meson build \
	&& meson install -C build \
	&& mv /usr/local/etc/ircd.conf.example /usr/local/etc/ircd.conf \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/*

FROM alpine:latest

RUN adduser -D ircd
RUN apk add --no-cache sqlite-dev mbedtls
COPY --from=builder --chown=ircd /usr/local /usr/local

USER ircd

EXPOSE 5000
EXPOSE 6665-6669
EXPOSE 6697
EXPOSE 9999

CMD ["/usr/local/bin/ophion", "-foreground"]
