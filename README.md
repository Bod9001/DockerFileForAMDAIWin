NOTE: 

docker is a bit weird inside of the virtual WSL2 Linux so you'll have to run a plane docker composed before it will allow the GPU pass through to work for some reason ( is part of the guide so don't worry too much )

confirm working with Windows10 and an RX7900XTX 

This is currently setup for automatic1111 and comfyUI, 

good news, I found the source of the crash

## if you have instant replay turned on it will crash
it will crash when generating images , when on the final step
workaround, turn off instant replay, 

the initial model loading takes ages for some reason, haven't worked out how to cash it on automatic_1111


## Requires

24.7.1 or newer AMD driver software version

an RDNA3 card 7XXX series, might work with 6XXX? idk Not able to test

docker desktop (when installed go to settings gear icon > resources > wsl integration > Enable Integration with additional distro ( You might need to add one if it's not visible Just search for ubuntu in window search and it comes up and set up) )

WSL2

plenty of free storage space,  maybe like 50gb? (for docker you can specify where the disc images located,  settings gear icon > resources > advanced > disk image location)

 
a hefty amount of RAM since the build likes to consume a lot for some reason best set in your WSL config 

```C:\Users\<account name>\.wslconfig```

```
[wsl2]
memory=50GB
swap=50GB
```
## How to steps for automatic1111

now, open a terminal in /wsl_2_rocm_docker_win and run docker file (if you haven't Built it already)

docker build -t wsl_2_rocm_docker_win . 

wait for it to finish ( this may take a while )

and then, 

go to /automatic_1111 and do 

docker build -t automatic_1111 . 

wait for it to finish ( this may take a while )

Load up a ubuntu wsl instance,

connect to it using the terminal , searching for ubuntu should bring up the terminal in Windows

and now, go to WSL2_set_up ( why? because for some reason if you don't run a normal docker then, run the one with the GPU Pass through  it bugs out weirdly and says it can't find the GPU )

then run

( remembering you have set up the docker integration )

sudo docker compose up 

wait for it to download and when it says it's running in docker desktop then press

ctrl+c to exit out of it (or close  in docker desktop )

go to 

and then navigate to the compose and do


sudo docker compose up

(it will download a few extra requirements since not quite sure how to pin them down)

and then it should load up, 

you need to then get the internal IP of your wsl container

wsl --list --verbose

then pick out the name for the one you're running the Docker compose on

wsl -d ```<DistributionName>``` hostname -I

that should give you an IP then simply do ```http://<foundIP>:7860/```

and then you should be connected to the UI

it will take a while since the model loading takes ages you can observe by your RAM slowly climbing, best to wait for it

then have fun!

## How to steps for comfyUI

now, open a terminal in /wsl_2_rocm_docker_win and run docker file (if you haven't Built it already)

docker build -t wsl_2_rocm_docker_win . 

wait for it to finish ( this may take a while )

and now, 

go to /comfy_ui and do 

docker build -t comfy_ui . 

wait for it to finish ( this may take a while )

Load up a ubuntu wsl instance,

connect to it using the terminal , searching for ubuntu should bring up the terminal in Windows

and now, go to WSL2_set_up ( why? because for some reason if you don't run a normal docker then, run the one with the GPU Pass through  it bugs out weirdly and says it can't find the GPU )

then run 

( remembering you have set up the docker integration )

sudo docker compose up

wait for it to download and when it says it's running in docker desktop then press

ctrl+c to exit out of it (or close  in docker desktop )

go to 

navigate to the docker compose  in comfy_ui and do

sudo docker compose up
and then it should load up, 

(Of course then provide your own model in the models/checkpoints folder)

you need to then get the internal IP of your wsl container

wsl --list --verbose

then pick out the name for the one you're running the Docker compose on

wsl -d ```<DistributionName>``` hostname -I

that should give you an IP then simply do ```http://<foundIP>:8188/```

and then you should be connected to the UI

if you got the model installed the and everything setup it should work! have fun

## How to steps for Swarm UI
so, First off follow the comfy UI  steps until  Load up a ubuntu wsl instance,
now 
go to /swarm_ui and do 

docker build -t swarm_ui . 

wait for it to finish ( this may take a while )

and now 
Load up a ubuntu wsl instance,

connect to it using the terminal , searching for ubuntu should bring up the terminal in Windows

and now, go to WSL2_set_up ( why? because for some reason if you don't run a normal docker then, run the one with the GPU Pass through  it bugs out weirdly and says it can't find the GPU )

then run 

then run 

( remembering you have set up the docker integration )

sudo docker compose up

wait for it to download and when it says it's running in docker desktop then press

ctrl+c to exit out of it (or close  in docker desktop )

go to 

navigate to the docker compose  in swarm_ui and do

sudo docker compose up
and then it should load up, 

(Of course then provide your own model in the models/checkpoints/OfficialStableDiffusion ( So it aligns nicely with what swarm UI Wants ) folder)

you need to then get the internal IP of your wsl container

wsl --list --verbose

then pick out the name for the one you're running the Docker compose on

wsl -d ```<DistributionName>``` hostname -I

that should give you an IP then simply do ```http://<foundIP>:7801/```

and then you should be connected to the UI

if you got the model installed the and everything setup it should work! have fun
