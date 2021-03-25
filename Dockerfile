FROM ubuntu:latest AS builder

VOLUME [ "/toolkit_tarballs" ]

ENV IS_IN_CONTAINER 1

RUN apt-get update \
 && apt-get -qy install git python3 wget ca-certificates

COPY . /source/WireGuard

ENTRYPOINT exec /source/WireGuard/build.sh

FROM build AS built
RUN /source/WireGuard/build.sh

FROM alpine
COPY --from=built /result_spk /result_spk
