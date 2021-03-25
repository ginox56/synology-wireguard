ARG PACKAGE_ARCH
ARG DSM_VER

FROM ubuntu:latest AS builder

VOLUME [ "/toolkit_tarballs" ]

ENV IS_IN_CONTAINER 1

RUN apt-get update \
 && apt-get -qy install git python3 wget ca-citertificates

COPY . /source/WireGuard

ENTRYPOINT exec /source/WireGuard/build.sh

FROM builder AS built
ARG PACKAGE_ARCH
ENV PACKAGE_ARCH=$PACKAGE_ARCH
ARG DSM_VER
ENV DSM_VER=$DSM_VER
RUN /source/WireGuard/build.sh

FROM alpine
COPY --from=built /result_spk /result_spk
