docker-compose up -d
docker attach wsl2_debug-wsl_2_rocm_docker_win-1

location=$(pip show torch | grep Location | awk -F ": " '{print $2}') && cd ${location}/torch/lib/

 /opt/rocm-6.4.0/bin/rocminfo

export LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/wsl:$LD_LIBRARY_PATH
rocminfo

strace -e openat ./usr/bin/rocminfo 2>&1 | grep '\.so'
LD_DEBUG=libs ./usr/bin/rocminfo 2>&1 | less
