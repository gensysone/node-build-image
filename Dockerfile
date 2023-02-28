FROM public.ecr.aws/amazonlinux/amazonlinux:2023

ENV VERSION_NODE=18
ENV VERSION_NODE_DEFAULT=$VERSION_NODE
ENV VERSION_YARN=3.4.1
ENV VERSION_AMPLIFY=7.6.14

## Install OS packages
RUN touch ~/.bashrc
RUN yum -y update && \
    yum -y install --skip-broken \
        alsa-lib-devel \
        autoconf \
        automake \
        bzip2 \
        bison \
        cmake \
        expect \
        fontconfig \
        git \
        gcc-c++ \
        gtk3-devel \
        libnotify-devel \
        libpng \
        libpng-devel \
        libffi-devel \
        libtool \
        libX11 \
        libXext \
        libxml2 \
        libxml2-devel \
        libXScrnSaver \
        libxslt \
        libxslt-devel \
        libyaml \
        libyaml-devel \
        make \
        nss-devel \
        openssl-devel \
        openssh-clients \
        patch \
        procps \
        python3 \
        python3-devel \
        readline-devel \
        sqlite-devel \
        tar \
        tree \
        unzip \
        wget \
        which \
        xorg-x11-server-Xvfb \
        zip \
        zlib \
        zlib-devel
#    yum clean all && \
#    rm -rf /var/cache/yum

## Install python3.9
RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
RUN tar xvf Python-3.9.0.tgz
WORKDIR Python-3.9.0
RUN ./configure --enable-optimizations --prefix=/usr/local
RUN make altinstall

## Install Node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install $VERSION_NODE && nvm use $VERSION_NODE && chown -R root:root /root/.nvm && \
    corepack enable && \
    corepack prepare yarn@${VERSION_YARN} --activate && \
    nvm alias default ${VERSION_NODE_DEFAULT} && nvm cache clear"

# Handle yarn for any `nvm install` in the future
RUN echo "yarn@${VERSION_YARN}" > /root/.nvm/default-packages

## Install awscli
RUN /bin/bash -c "pip3.9 install awscli && rm -rf /var/cache/apk/*"

## Install AWS Amplify CLI for all node versions
RUN /bin/bash -c ". ~/.nvm/nvm.sh && nvm use $VERSION_NODE  && \
    npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}" \

## Environment Setup
RUN echo export PATH="\
    /root/.nvm/versions/node/${VERSION_NODE_DEFAULT}/bin:\
    $PATH" >> ~/.bashrc && \
    echo "nvm use ${VERSION_NODE_DEFAULT} 1> /dev/null" >> ~/.bashrc

EXPOSE 3000
ENTRYPOINT [ "bash", "-c" ]
