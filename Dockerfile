FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

# Environment setup
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    PYENV_ROOT="/root/.pyenv" \
    PATH="/root/.pyenv/bin:/root/.pyenv/shims:/root/.local/bin:/usr/local/bin:$PATH"

# Version arguments
ARG VERSION_PYTHON="3.12.7"
ARG VERSION_POETRY="2.2.1"

# # install pyenv, python and dev tools
RUN apt update && \
    apt install -y --no-install-recommends \
        make build-essential git curl ca-certificates \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev \
        libxmlsec1-dev libffi-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/* && \
    # Install pyenv
    git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" && \
    # Install desired Python version
    pyenv install ${VERSION_PYTHON} && \
    pyenv global ${VERSION_PYTHON} && \
    # Install Poetry
    curl -sSL https://install.python-poetry.org | POETRY_VERSION=${VERSION_POETRY} python - && \
    # make poetry globally available
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry
# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
