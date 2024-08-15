FROM wsl_2_rocm_docker_win

WORKDIR /

RUN apt install -y git

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

RUN pip3 install -r /stable-diffusion-webui/requirements.txt

# Expose necessary port
EXPOSE 7860

# Define the command to run the web UI at container start
CMD ["python3", "/stable-diffusion-webui/launch.py", "--listen"]