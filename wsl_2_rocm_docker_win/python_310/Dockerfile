# Use the official Ubuntu image from the Docker Hub
FROM ubuntu:24.04

# Set the working directory
WORKDIR /amd

# Set environment variables to avoid user interaction during the installation process
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update
	
RUN apt-get remove python3.12 -y	
	
# Install Python versions and pip
RUN apt-get install -y \
    python3.10 \
    python3-pip	


# Update the package lists and upgrade the packages
RUN apt update

# Install wget
RUN apt-get install -y wget

RUN apt-get install -y software-properties-common

RUN add-apt-repository universe && apt-get update

RUN apt-get install -y libtinfo6

RUN apt-get install -y libsuitesparse-dev

RUN apt-get install -y libccolamd3

RUN apt-get install -y libcamd3

RUN apt-get install -y libcolamd3

RUN apt-get install -y libamd3

RUN apt-get install -y libsuitesparse-dev

RUN apt-get install -y libncurses6

#RUN apt-get install -y mime-support

RUN apt-get install -y libssl3

RUN apt-get install -y libffi8 

#RUN apt-get install -y libmpdec3

RUN wget https://repo.radeon.com/amdgpu-install/6.3.4/ubuntu/noble/amdgpu-install_6.3.60304-1_all.deb
RUN apt install ./amdgpu-install_6.3.60304-1_all.deb -y

RUN amdgpu-install -y --usecase=wsl,rocm --no-dkms

RUN pip3 install numpy==1.26.4 --break-system-packages

RUN wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torch-2.4.0%2Brocm6.3.4.git7cecbf6d-cp310-cp310-linux_x86_64.whl
RUN wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torchvision-0.19.0%2Brocm6.3.4.gitfab84886-cp310-cp310-linux_x86_64.whl
RUN wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/pytorch_triton_rocm-3.0.0%2Brocm6.3.4.git75cc27c2-cp310-cp310-linux_x86_64.whl
RUN wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3.4/torchaudio-2.4.0%2Brocm6.3.4.git69d40773-cp310-cp310-linux_x86_64.whl
RUN pip3 uninstall torch torchvision pytorch-triton-rocm --break-system-packages

RUN dir

RUN apt remove python3-pip -y

RUN apt-get update
RUN apt-get install -y python3.10 python3.10-venv python3.10-distutils
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN ln -sf /usr/local/bin/pip3.10 /usr/bin/pip3
RUN python3.10 -m ensurepip --upgrade
RUN pip debug --verbose

RUN apt install python3 python3-pip -y

RUN pip3 install -v pytorch_triton_rocm-3.0.0+rocm6.3.4.git75cc27c2-cp310-cp310-linux_x86_64.whl --break-system-packages
RUN pip3 install -v torchvision-0.19.0+rocm6.3.4.gitfab84886-cp310-cp310-linux_x86_64.whl  --break-system-packages
RUN pip3 install -v torch-2.4.0+rocm6.3.4.git7cecbf6d-cp310-cp310-linux_x86_64.whl --break-system-packages
RUN pip3 install -v torchaudio-2.4.0+rocm6.3.4.git69d40773-cp310-cp310-linux_x86_64.whl --break-system-packages

RUN pip3 install -U setuptools --break-system-packages

# Locate the torch library directory
RUN location=$(pip show torch | grep Location | awk -F ": " '{print $2}') && \
    cd "$location/torch/lib/" && \
    rm libhsa-runtime64.so*