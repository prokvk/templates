FROM golang:alpine
MAINTAINER "HashiCorp Terraform Team <terraform@hashicorp.com>"

ENV TERRAFORM_VERSION=0.11.11

RUN apk add --update git bash openssh rsync zip

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
git checkout v${TERRAFORM_VERSION} && \
/bin/bash scripts/build.sh

# ansible
RUN echo "===> Installing ansible..."  && \
	echo "===> Adding Python runtime..."  && \
	apk --update add python py-pip openssl ca-certificates	&& \
	apk --update add --virtual build-dependencies \
				python-dev libffi-dev openssl-dev build-base  && \
	pip install --upgrade pip cffi							&& \
	pip install git+git://github.com/ansible/ansible.git@stable-2.6	&& \
	\
	\
	echo "===> Removing package list..."  && \
	apk del build-dependencies			&& \
	rm -rf /var/cache/apk/*			   && \
	\
	\
	echo "===> Adding hosts for convenience..."  && \
	mkdir -p /etc/ansible						&& \
	echo 'localhost ansible_connection=local ansible_user=root' > /etc/ansible/hosts

# awscli
RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

WORKDIR $GOPATH
