FROM wsl_2_rocm_docker_win_py132

# Set the working directory
WORKDIR /

RUN apt install -y git

RUN git clone https://github.com/Stability-AI/StableSwarmUI

RUN apt install -y libglib2.0-0 libgl1

# install dotnet
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x dotnet-install.sh

# Note: manual installers that want to avoid home dir, add to both of the below lines: --install-dir $SCRIPT_DIR/.dotnet
RUN ./dotnet-install.sh --channel 8.0 --runtime aspnetcore
RUN ./dotnet-install.sh --channel 8.0
RUN cd ..

# Expose necessary port
EXPOSE 7801

# Define the command to run the web UI at container start
CMD ["bash", "StableSwarmUI/launch-linux.sh"]