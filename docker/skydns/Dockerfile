FROM ubuntu:14.04

ENV GOROOT /go/root
ENV GOPATH /go/path
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN sudo apt-get -y update && apt-get install -y curl build-essential git

# Install Go from source
RUN mkdir -p ${GOROOT} ${GOPATH} && \
    curl -s https://storage.googleapis.com/golang/go1.3.src.tar.gz | tar -vxz \
      --strip-components=1 -C ${GOROOT} && \
    cd ${GOROOT}/src && \
    ./make.bash --no-clean 2>&1 && \
    go get github.com/tools/godep

# Install SkyDNS
RUN go get github.com/skynetservices/skydns && \
    cd ${GOPATH}/src/github.com/skynetservices/skydns && \
    go build -v

# Expose ports
#   53    DNS
EXPOSE 53

# Add boot script
ADD bin/boot.sh /bin/
ENTRYPOINT [ "/bin/booti.sh" ]