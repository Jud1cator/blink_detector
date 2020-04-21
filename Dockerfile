FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential cmake \
        libgtk-3-dev \
        libboost-all-dev \
        python3-pip \
        python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

WORKDIR /src
COPY . .

ENTRYPOINT ["./entrypoint.sh"]