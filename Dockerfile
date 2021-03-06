FROM alpine:3.11

MAINTAINER  Charles Sibbald <charles@georgiapipeline.io>

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip sed

ENV K8S_VERSION="v1.19.0"
ENV HELM_VERSION="v3.3.4"
ENV VELERO_VERSION="v1.5.1"

ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -L https://get.helm.sh/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 \
 && curl -L https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz | tar xz \
 && mv velero-${VELERO_VERSION}-linux-amd64/velero /usr/local/bin/velero && chmod +x /usr/local/bin/velero \
 && rm -rf velero-${VELERO_VERSION}-linux-amd64 \
 && curl -L https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc && chmod +x /usr/local/bin/mc

RUN apk del --purge deps && rm /var/cache/apk/*

