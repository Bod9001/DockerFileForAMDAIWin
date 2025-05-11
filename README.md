NOTE:
Update: 12/05/2025
Half a year later updated to Rocm 6.3.4, 

so, Official images not tested
forge UI, was able to get a generation out but not sure if it's me trying to run a full fat flux and proceeding to run out of VRAM that's breaking it, 
so it definitely needs some tweaking and looking to
automatic1111 ok, 
comfyUI ok,
swarmUI, I think the configurations need to be updated, but it's a c# calling comfyUI API so not really AMD/ROCM related

was able to find a fix for docker consuming all your memory on Windows

also cleaned up the rocker files as well to be a bit more resilient, though is missing git hashes, so now properly update some of the linked githubs and break stuff
tested on following commits
AUTOMATIC1111 = https://github.com/AUTOMATIC1111/stable-diffusion-webui/commit/82a973c04367123ae98bd9abdf80d9eda9b910e2
ComfyUI = https://github.com/comfyanonymous/ComfyUI/commit/577de83ca9c99e997825439e017113456c4c78f7
forge UI = https://github.com/lllyasviel/stable-diffusion-webui-forge/commit/0ced1d0cd000a536ebd21dc2c8e8636c9104568d
swarmUI = https://github.com/mcmonkeyprojects/SwarmUI/commit/9834101d5f965b0e6822d58c7528da1e7353bd47

Update: 05/12/2024 

looks like AMD is providing their own prebuilt images if you would like to use the those, however the pretty chunky 
https://hub.docker.com/r/rocm/pytorch/tags
and
they updated the rocm version for WSL  (Link has docker instructions to)
https://rocm.docs.amd.com/projects/radeon/en/latest/docs/install/wsl/install-radeon.html

~~haven't been able to get flux.dev working it always freezes up the entire computer when processing vae tell me if you manage to get past this for flux.dev~~
technically fixed it I think it's an issue with VAE steps in the driver, I recently upgraded to 64GB of ram from 32GB, and when the point it would usually crash when doing the VAE, 
it is when it spikes up in memory and Does the same thing but doesn't crash, 
remedy? if you don't have the hardware may be temporarily increasing your ram cash/whatever it's called file so it can temporarily allocate it, interestingly don't seem to spike after it's done it 1st/2nd time, Probably some JIT compiling on the AMD side using too much memory  

docker is a bit weird inside of the virtual WSL2 Linux so you'll have to run a plane docker composed before it will allow the GPU pass through to work for some reason ( is part of the guide so don't worry too much )

confirm working with Windows10 and an RX7900XTX 

This is currently setup for automatic1111 , comfyUI , swarmUI (with comfyUI backend) and forge_ui, 

good news, I found the source of the crash

## if you have instant replay turned on it will crash
it will crash when generating images , when on the final step
workaround, turn off instant replay, 



## to fix a docker bug where docker will consume all your memory
```
wsl --list --running
wsl -d docker-desktop
sync; echo 3 | tee /proc/sys/vm/drop_caches
```
so it looks like the issues it doesn't clean out the caches so if it starts using a lot of RAM, do the steps above, to go into the docker desktop container and tell it to clean out the cash, 
with this actually able to download the official AMD images,
note they haven't been tested



## Requires

24.7.1 or newer AMD driver software version

an RDNA3 card 7XXX series, might work with 6XXX? idk Not able to test
someone tried an RX 6950 XT and the GPU was being recognised in the container, no confirmation on if it worked properly tho

docker desktop (when installed go to settings gear icon > resources > wsl integration > Enable Integration with additional distro ( You might need to add one if it's not visible Just search for ubuntu in window search and it comes up and set up) )

WSL2

plenty of free storage space,  maybe like 50gb? (for docker you can specify where the disc images located,  settings gear icon > resources > advanced > disk image location)

 
a hefty amount of RAM since the build likes to consume a lot for some reason best set in your WSL config 

```C:\Users\<account name>\.wslconfig``` 

( if not present add it, make sure to turn on file extensions in Windows Explorer so you **don't** get something like .wslconfig.txt )

```
[wsl2]
memory=50GB
swap=50GB
```
(Once you finish building your images It's advisable to turn memory back down to something that doesn't consume all your memory on your computer, 
since (docker) Linux does that thing where it thinks it's free memory so fills it up with random stuff but Windows doesn't know about that so you end up with your memory being filled up)

and then  Restart wsl with this in Windows terminal wsl --shutdown
then docker desktop should prompt to restart wsl and you allow it to do  so

## HOW to steps

First navigate to wsl_2_rocm_docker_win, 
ensuring that you have docker running, and HIP ( for windows installed I'm not too sure if it's needed ),And the latest driver, and you have instant replay turned off (causes a crash)

for
forge_ui =  python_310
automatic_1111 =  python_310
swarm_ui = python_312
comfy_ui = python_312
and run the build.bat ( it'll take a while and a lot of system resources, if you want you can open a terminal and run it in that so it doesn't instantly close once it's finished )

once that is finished go to the custom_image folder
Go to the Application you want to run and run build.bat ( again this will take a little bit )
once it has finished successfully 
(if swarm_ui, you need to go to comfy_ui and run the build.bat in there)
run the run.bat 
and if you check docker desktop it should be loading up,

then depending on the application
automatic_1111 = (gradio URL from logs working, localhost not working for some reason localhost:7860)
forge_ui = (gradio URL from logs working, localhost not working for some reason localhost:7860)
comfy_ui = localhost:8188
swarm_ui = localhost:7801

NOTES:
for automatic_1111 and forge_ui
for some reason it doesn't work unless you use the public links that are generated in the docker logs, you can look at them in docker desktop,   example URL  random numbers and characters.gradio.live 
Haven't been able to work out why just localhost doesn't work, 

the initial model loading takes ages for some reason, haven't worked out how to cash it on automatic_1111


then have fun!
