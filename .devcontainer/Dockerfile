FROM alpine:3.11 AS get_terraform
RUN apk update \
    && apk add --no-cache \
    wget \
    unzip \
    ca-certificates

ARG TF_VERSION=0.12.24
ADD https://releases.hashicorp.com/terraform/0.12.24/terraform_${TF_VERSION}_linux_amd64.zip terraform.zip
RUN unzip terraform.zip

#FROM alpine:3.11
FROM ubuntu:19.10

ENV USERNAME=nonroot
ENV USER_UID=1000
ENV USER_GID=$USER_UID

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
    ca-certificates \
    zsh \
    git \
    jq \
    inotify-tools \
    && rm -rf /var/lib/apt/lists*

RUN groupadd \
    --gid $USER_GID \
    $USERNAME
RUN useradd \
    --shell $(which zsh) \
    --key MAIL_DIR=/dev/null \
    --uid $USER_UID \
    --gid $USER_GID \
    --create-home \
    $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

RUN touch .zshrc
ENTRYPOINT /bin/zsh

COPY --chown=0:0 --from=get_terraform terraform /usr/local/bin/terraform