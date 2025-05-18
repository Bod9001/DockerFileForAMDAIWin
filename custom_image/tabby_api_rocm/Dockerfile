FROM wsl_2_rocm_docker_win_py132

# Set the working directory
WORKDIR /

# Install necessary tools
RUN apt update && apt install -y git

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates

RUN git clone https://github.com/theroyallab/tabbyAPI.git

RUN sed -i '/torch @/d' /tabbyAPI/pyproject.toml && \
    cat /tabbyAPI/pyproject.toml
	
RUN sed -i '/pytorch_triton_rocm @/d' /tabbyAPI/pyproject.toml && \
    cat /tabbyAPI/pyproject.toml

RUN sed -i '/exllamav2 @/d' /tabbyAPI/pyproject.toml && \
    cat /tabbyAPI/pyproject.toml

WORKDIR /tabbyAPI
RUN pip3 install --no-cache-dir .[amd,extras] --break-system-packages
WORKDIR /

RUN git clone https://github.com/turboderp/exllamav2
WORKDIR /exllamav2
RUN pip3 install -r requirements.txt --break-system-packages

RUN mkdir -p /lib/glibc-hwcaps/x86-64-v3


RUN apt-get update && apt-get install -y curl 

#libd3d12.so
RUN curl -L https://raw.githubusercontent.com/Bod9001/DockerFileForAMDAIWin/refs/heads/main/custom_image/tabby_api_rocm/lib/libd3d12.so \
    -o /lib/glibc-hwcaps/x86-64-v3/libd3d12.so


#libd3d12core.so
RUN curl -L https://raw.githubusercontent.com/Bod9001/DockerFileForAMDAIWin/refs/heads/main/custom_image/tabby_api_rocm/lib/libd3d12core.so \
    -o /lib/glibc-hwcaps/x86-64-v3/libd3d12core.so

#libdxcore.so
RUN curl -L https://raw.githubusercontent.com/Bod9001/DockerFileForAMDAIWin/refs/heads/main/custom_image/tabby_api_rocm/lib/libdxcore.so \
    -o /lib/glibc-hwcaps/x86-64-v3/libdxcore.so

RUN ls /lib/glibc-hwcaps/x86-64-v3

# Locate the torch library directory
#RUN location=$(pip show torch | grep Location | awk -F ": " '{print $2}') && \
#    cd "$location/torch/lib/" && \
#    rm libhsa-runtime64.so*

ENV EXLLAMA_NOCOMPILE=0

RUN ldd /usr/local/lib/python3.12/dist-packages/torch/_C.cpython-312-x86_64-linux-gnu.so
RUN LD_DEBUG=libs python3 -c "import torch" 2>&1 | grep libdxcore

RUN pip3 install . --break-system-packages
WORKDIR /

EXPOSE 5000

CMD ["python3", "tabbyAPI/server.py"]