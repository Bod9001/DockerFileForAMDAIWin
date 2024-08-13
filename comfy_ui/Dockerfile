FROM wsl_2_rocm_docker_win

# Set the working directory
WORKDIR /

RUN apt install -y git

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

RUN pip3 install -r /ComfyUI/requirements.txt

# Expose necessary port
EXPOSE 8188

# Define the command to run the web UI at container start
CMD ["python3", "/ComfyUI/main.py", "--listen"]