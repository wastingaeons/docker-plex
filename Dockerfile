FROM linuxserver/plex:latest AS base

RUN DEBIAN_FRONTEND="noninteractive" TZ="America/Los_Angeles" apt update && apt -y install tzdata

RUN apt -y install cmake pkg-config python ocl-icd-dev libegl1-mesa-dev ocl-icd-opencl-dev libdrm-dev libxfixes-dev libxext-dev llvm-7-dev clang-7 libclang-7-dev libtinfo-dev libedit-dev zlib1g-dev build-essential git

RUN git clone --branch comet-lake https://github.com/rcombs/beignet.git
RUN mkdir -p /beignet/build/
RUN cd /beignet/build && cmake -DLLVM_INSTALL_DIR=/usr/lib/llvm-7/bin .. && make -j8 && make install

FROM linuxserver/plex:latest AS img

RUN apt update && apt -y install clinfo
COPY --from=0 /usr/local/include/CL /usr/local/include/CL
COPY --from=0 /usr/local/lib/beignet /usr/local/lib/beignet
COPY --from=0 /usr/local/lib/beignet /usr/lib/x86_64-linux-gnu/beignet
COPY --from=0 /usr/local/share/metainfo/com.intel.beignet.metainfo.xml /usr/share/metainfo/
