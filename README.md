NOTE: 

This is currently setup for automatic1111, 

AND seems to crash with a RX7900 xtx when generating images greater than 600x600 for some reason, it pops up a driver crash on the Windows side for some reason

![image](https://github.com/user-attachments/assets/1f9dc3be-0aec-4053-8b5b-4a488c54448f)

All of this is done in an hacky way just to get it working, however I've hit a brick wall with this unexplained crash so Decided to leave it for the meanwhile, if you want to contact me about doing something with this Bod9001 on discord (mainly because I forget to check github notifications)


the initial model loading takes ages for some reason, haven't worked out how to cash it


Requires

https://www.amd.com/en/resources/support-articles/release-notes/RN-RAD-WIN-24-10-21-01-WSL-2.html

an RDNA3 card 7XXX series (because the driver doesn't install on anything else)

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

now, open a terminal to the docker file and run 

docker build -t stable-diffusion-amd-wsl . 

wait for it to finish ( this may take a while )

and now, 

Load up a ubuntu wsl instance,

connect to it and then navigate to the compose and do

( remembering you have set up the docker integration )

docker compose up

(it will download a few extra requirements since not quite sure how to pin them down)

and then it should load up, 

you need to then get the internal IP of your wsl container

wsl --list --verbose

then pick out the name for the one you're running the Docker compose on

wsl -d ```<DistributionName>``` hostname -I

that should give you an IP then simply do ```http://<foundIP>:7860/```

and then you should be connected to the UI
