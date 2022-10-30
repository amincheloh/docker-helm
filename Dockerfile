FROM alpine:3.16.2
LABEL maintainer "Amin Cheloh <amincheloh@gmail.com>"

ARG KUBECTL_VERSION=1.25.3
ARG HELM_VERSION=3.10.1
ARG HELM_PUSH_VERSION=0.10.3

RUN apk add --no-cache \
    curl \
    git \
  && echo done

RUN wget https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    -O /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - \
  | tar -C /usr/local/bin --strip-components 1 -zxf - linux-amd64/helm

RUN helm plugin install https://github.com/chartmuseum/helm-push.git --version ${HELM_PUSH_VERSION}
