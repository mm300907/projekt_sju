ARG VARIANT=3.12-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# Jupyter environment

RUN apt-get update || (sleep 5 && apt-get update) && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    ca-certificates \
    tar \
    procps \
    locales \
    && rm -rf /var/lib/apt/lists/*


RUN pip3 install --disable-pip-version-check --no-cache-dir \
    ipykernel \
    jupyter \
    qiskit \
    matplotlib \
    Pillow \
    pycryptodomex \
    cryptography \
    pylatexenc

COPY test.py /home/vscode/workspace/test.py

USER vscode

RUN mkdir -p /home/vscode/workspace
