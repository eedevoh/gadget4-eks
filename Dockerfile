FROM ubuntu:22.04 as builder

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgsl-dev \
    libfftw3-dev \
    libhdf5-dev \
    libopenmpi-dev \
    openmpi-bin \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/weiguangcui/Gadget4.git

WORKDIR /app/Gadget4
RUN mkdir -p build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j $(nproc) && \
    make install

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    libgsl27 \
    libfftw3-3 \
    libhdf5-103 \
    libopenmpi3 \
    openmpi-bin \
    python3 \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/Gadget4 /usr/local/bin/

data
WORKDIR /data

ENTRYPOINT ["mpirun", "-np", "4", "Gadget4"]
CMD ["/data/params.yml"]