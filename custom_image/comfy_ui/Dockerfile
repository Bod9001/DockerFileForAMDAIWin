FROM wsl_2_rocm_docker_win_py132

# Set the working directory
WORKDIR /

# Install necessary tools
RUN apt update && apt install -y git

# Clone the ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Remove specific packages from the requirements.txt
RUN sed -i '/torch/d' /ComfyUI/requirements.txt && \
    sed -i '/torchvision/d' /ComfyUI/requirements.txt && \
    sed -i '/torchaudio/d' /ComfyUI/requirements.txt

# Install the remaining dependencies
RUN pip3 install torchsde --break-system-packages

RUN pip3 install -r /ComfyUI/requirements.txt --break-system-packages

# Expose the necessary port
EXPOSE 8188

# Define the command to run the web UI at container start
CMD ["python3", "/ComfyUI/main.py", "--listen"]