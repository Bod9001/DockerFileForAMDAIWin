# Use the official Ubuntu image from the Docker Hub
FROM ubuntu:latest

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
	
# Install Python versions and pip
RUN apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip	


# Update the package lists and upgrade the packages
RUN apt update

# Install wget
RUN apt-get install -y wget

RUN apt-get install -y software-properties-common
RUN add-apt-repository universe

RUN wget http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.2-0ubuntu2.1_amd64.deb
RUN apt-get install -y ./libtinfo5_6.2-0ubuntu2.1_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/s/suitesparse/libsuitesparseconfig5_5.10.1+dfsg-4build1_amd64.deb
RUN apt-get install -y ./libsuitesparseconfig5_5.10.1+dfsg-4build1_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/universe/s/suitesparse/libccolamd2_5.10.1+dfsg-4build1_amd64.deb
RUN apt-get install -y ./libccolamd2_5.10.1+dfsg-4build1_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/s/suitesparse/libcamd2_5.7.1+dfsg-2_amd64.deb
RUN apt-get install -y ./libcamd2_5.7.1+dfsg-2_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/s/suitesparse/libcolamd2_5.7.1+dfsg-2_amd64.deb
RUN apt-get install -y ./libcolamd2_5.7.1+dfsg-2_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/s/suitesparse/libamd2_5.7.1+dfsg-2_amd64.deb
RUN apt-get install -y ./libamd2_5.7.1+dfsg-2_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/s/suitesparse/libcholmod3_5.7.1+dfsg-2_amd64.deb
RUN apt-get install -y ./libcholmod3_5.7.1+dfsg-2_amd64.deb

RUN wget http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncurses5_6.2-0ubuntu2.1_amd64.deb
RUN apt-get install -y ./libncurses5_6.2-0ubuntu2.1_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/m/mime-support/mime-support_3.66_all.deb
RUN apt-get install -y ./mime-support_3.66_all.deb

RUN wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.22_amd64.deb
RUN apt-get install -y ./libssl1.1_1.1.1f-1ubuntu2.22_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/universe/libf/libffi7/libffi7_3.3-5ubuntu1_amd64.deb
RUN apt-get install -y ./libffi7_3.3-5ubuntu1_amd64.deb

RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/main/m/mpdecimal/libmpdec2_2.4.2-3_amd64.deb
RUN apt-get install -y ./libmpdec2_2.4.2-3_amd64.deb

# Download the AMD GPU installer package
RUN wget https://repo.radeon.com/amdgpu-install/6.1.3/ubuntu/jammy/amdgpu-install_6.1.60103-1_all.deb

RUN apt-get install -y ./amdgpu-install_6.1.60103-1_all.deb

RUN amdgpu-install -y --usecase=wsl,rocm --no-dkms

# Set the working directory
WORKDIR /stable-diffusion

# Define a build argument
ARG CACHEBUST=6

# Download the webui.sh script 
RUN wget -q https://raw.githubusercontent.com/Bod9001/DockerFileForAMDAIWin/main/automatic1111_modified_install_script.sh && echo $CACHEBUST

RUN apt install -y git
# Make the script executable
RUN chmod +x automatic1111_modified_install_script.sh

# Reconfirm script location and permissions
RUN ls -l /stable-diffusion/automatic1111_modified_install_script.sh

# Run the script during the build process
RUN /bin/bash -c "./automatic1111_modified_install_script.sh"

# Set up update-alternatives for python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 2

# Set default python3 version
RUN update-alternatives --set python3 /usr/bin/python3.10

# Set up update-alternatives for python (optional)
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.12 2

# Set default python version (optional)
RUN update-alternatives --set python /usr/bin/python3.10

RUN pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/rocm6.1

RUN pip3 install -U setuptools


RUN pip3 install lightning --break-system-packages
RUN pip3 install gradio --break-system-packages

RUN pip3 install numpy --break-system-packages
RUN pip3 install libsgm --break-system-packages

RUN pip3 install omegaconf --break-system-packages
RUN pip3 install safetensors --break-system-package
RUN pip3 install kornia --break-system-package
RUN pip3 install open-clip-torch --break-system-package

RUN pip3 install einops --break-system-package

RUN pip3 install transformers==4.30.2 --break-system-package
RUN pip3 install scipy --break-system-package

RUN pip3 install diskcache --break-system-package

RUN pip3 install GitPython --break-system-package

RUN pip3 install pytorch-lightning==1.7.7 --break-system-package
RUN pip3 install torchmetrics==0.11.4 --break-system-package
RUN pip3 install opencv-python --break-system-package
RUN pip3 install scikit-image --break-system-package

RUN pip3 install psutil --break-system-package
RUN pip3 install piexif --break-system-package
RUN pip3 install pillow-avif-plugin==1.4.3 --break-system-package

RUN pip3 install torchsde --break-system-package
RUN pip3 install torchdiffeq --break-system-package
RUN pip3 install tomesd --break-system-package
RUN pip3 install resize-right --break-system-package
RUN pip3 install requests --break-system-package

RUN pip3 install lark --break-system-package
RUN pip3 install jsonmerge --break-system-package
RUN pip3 install inflection --break-system-package
RUN pip3 install gradio==3.41.2 --break-system-package

RUN pip3 install fastapi>=0.90.1 --break-system-package

RUN pip3 install facexlib --break-system-package

RUN pip3 install scikit-image>=0.19 --break-system-package

RUN pip3 install clean-fid --break-system-package

RUN pip3 install blendmodes --break-system-package

RUN pip3 install accelerate --break-system-package

RUN pip3 install Pillow --break-system-package
RUN pip3 install clip --break-system-package

RUN pip3 install pydantic


# Locate the torch library directory
RUN location=$(pip show torch | grep Location | awk -F ": " '{print $2}') && \
    cd ${location}/torch/lib/ && \
    rm -f libhsa-runtime64.so* && \
    cp /opt/rocm/lib/libhsa-runtime64.so.1.2 libhsa-runtime64.so

# Expose necessary port
EXPOSE 7860

# Define the command to run the web UI at container start
CMD ["python3", "/stable-diffusion/stable-diffusion-webui/stable-diffusion-webui/launch.py", "--listen"]