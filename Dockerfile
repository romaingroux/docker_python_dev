FROM ubuntu@sha256:aa772c98400ef833586d1d517d3e8de670f7e712bf581ce6053165081773259d
SHELL ["/bin/bash", "-c"]

ENV CONTAINER_NAME="python3.9-dev-ubuntu"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PATH="/usr/local/bin:$PATH"

# version numbers
# version numbers
ARG VERSION_PYTHON="3.9"
ARG VERSION_LINEPROFILE="3.1.0"
ARG VERSION_PANDAS="1.1.5"
ARG VERSION_SCIPY="1.13.0"
ARG VERSION_NUMPY="1.26.0"
ARG VERSION_PLOTLY="5.10.0"
ARG VERSION_CLICK="8.1.3"
ARG VERSION_FASTAPI="0.85.0"
ARG VERSION_PYDANTIC="2.7.1"
ARG VERSION_PYMONGO="4.2.0"
ARG VERSION_PYTEST="8.2.0"
ARG VERSION_TOX="4.15.0"


# install python and dev tools
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt install -y python${VERSION_PYTHON} && \
    apt install -y python${VERSION_PYTHON}-distutils && \
    apt install -y python3.9-dev && \
	apt install -y python3-pip\
    apt install -y git


# install python libraries
# line-profile
RUN python${VERSION_PYTHON} -m pip install line-profiler==${VERSION_LINEPROFILE} && \
# pandas
python${VERSION_PYTHON} -m pip install pandas==${VERSION_PANDAS} && \
# scipy
python${VERSION_PYTHON} -m pip install scipy==${VERSION_SCIPY} && \
# numpy
python${VERSION_PYTHON} -m pip install numpy==${VERSION_NUMPY} && \
# plotly
python${VERSION_PYTHON} -m pip install plotly==${VERSION_PLOTLY} && \
# kaleido and psutil so that plotly can save images
python${VERSION_PYTHON} -m pip install -U kaleido && \
python${VERSION_PYTHON} -m pip install psutil && \
# click
python${VERSION_PYTHON} -m pip install click==${VERSION_CLICK} && \
# fastapi
python${VERSION_PYTHON} -m pip install fastapi==${VERSION_FASTAPI} && \
# pydantic
python${VERSION_PYTHON} -m pip install pydantic==${VERSION_PYDANTIC} && \
# pymango
python${VERSION_PYTHON} -m pip install pymongo==${VERSION_PYMONGO} && \
# pytest
python${VERSION_PYTHON} -m pip install pytest==${VERSION_PYTEST} && \
# tox
python${VERSION_PYTHON} -m pip install tox==${VERSION_TOX}


# clean caches
RUN apt clean