FROM alpine:3.9

ENV PACKER_VERSION="1.2.4"

ENV USER_NAME agent-user
ENV USER_GROUP agent-user

ARG UID=10000
ARG GID=10000

RUN addgroup -S $USER_GROUP -g $GID
RUN adduser -S -G $USER_GROUP $USER_NAME -u $UID

RUN apk --update --no-cache add \
        ca-certificates \
	curl 
		
RUN curl https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o packer_${PACKER_VERSION}_linux_amd64.zip 
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin \
 && rm -rf packer_${PACKER_VERSION}_linux_amd64.zip
 
RUN apk del curl
		
RUN rm -rf /var/cache/apk/* \
 && rm -rf ~/.cache/pip
 
RUN mkdir -p /workspace/

USER $USER_NAME

WORKDIR /workspace
CMD ["/bin/sh"]