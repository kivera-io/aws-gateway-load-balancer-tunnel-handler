FROM amd64/amazonlinux:2 AS build

ADD . /usr/local
WORKDIR /usr/local

RUN yum groupinstall "Development Tools" -y
RUN yum install cmake3 -y
RUN cmake3 . && make

FROM scratch AS binary
    COPY --from=build /usr/local/gwlbtun /
