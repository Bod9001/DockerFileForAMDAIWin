import os
import subprocess

# Define the base directory
base_dir = '/ComfyUI/custom_nodes'

# Loop through each folder in the base directory
for folder_name in os.listdir(base_dir):
    folder_path = os.path.join(base_dir, folder_name)
    
    if os.path.isdir(folder_path):
        requirements_file = os.path.join(folder_path, 'requirements.txt')
        
        if os.path.isfile(requirements_file):
            # Install the requirements
            subprocess.run(['pip', 'install', '-r', requirements_file], check=True)

# Run the main.py script
subprocess.run(['python3', '/ComfyUI/main.py', '--listen'], check=True)