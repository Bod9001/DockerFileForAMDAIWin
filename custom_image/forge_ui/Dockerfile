FROM wsl_2_rocm_docker_win

# Set the working directory
WORKDIR /

RUN apt install -y git

RUN git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git

RUN pip3 install -r /stable-diffusion-webui-forge/requirements_versions.txt

# Expose necessary port
EXPOSE 7869

# Define the command to run the web UI at container start
CMD ["python3", "/stable-diffusion-webui-forge/launch.py", "--listen"]