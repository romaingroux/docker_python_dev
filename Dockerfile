FROM ubuntu@sha256:aa772c98400ef833586d1d517d3e8de670f7e712bf581ce6053165081773259d
SHELL ["/bin/bash", "-c"]

ENV CONTAINER_NAME="python3.12-ubuntu"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PATH="/usr/local/bin:$PATH"

# version numbers
ARG VERSION_PYTHON="3.12"
ARG VERSION_POETRY="2.2.1"

# install python and dev tools
RUN apt update && \
    apt install -y software-properties-common curl && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt install -y \
        python${VERSION_PYTHON} \
        python${VERSION_PYTHON}-venv \
        python${VERSION_PYTHON}-dev \
        build-essential && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python${VERSION_PYTHON} && \
    curl -sSL https://install.python-poetry.org | POETRY_VERSION=${VERSION_POETRY} python${VERSION_PYTHON} - && \
    echo -e '\nexport PATH="/root/.local/bin:$PATH"' >> ~/.bashrc

# clean caches
RUN apt clean