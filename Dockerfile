FROM alpine:3.12 as build

RUN apk add build-base abuild binutils binutils-doc cmake musl musl-dev
RUN apk add git
COPY build.sh ./
RUN chmod +x build.sh && ./build.sh
