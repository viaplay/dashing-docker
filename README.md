dashing-docker
==============



## Description

The dashing-docker project is a docker image building project that can run any dashing project in a docker container. The particular dashing project as well as startup procedure can be maintained outside of the container.


### Purpose

The sole purpose of this approach is to streamline the setup on the running server. Build and test locally in any way you feel comfortable with and use this docker image on the server. Altough docker, not yet, is suitable for production a dashing project often is used behind a firewall locally in the office.



## Run the dashing sample

Clone this project if you want to run the dashing sample provided within. You can then chose to use the pre made docker image or build it yourself from the Dockerfile. 

*The sample is provided by dashing itself and included in this project for easy learning. Read more here: http://shopify.github.io/dashing/*


### Use the pre built image
The pre built image can be downloaded using docker directly. After that you do not need to use this command again, you will have the image on your machine.

	$ sudo docker pull viaplay/dashing


### Build the docker image by yourself
If you prefer you can easily build the docker image by yourself. After this the image is ready for use on your machine and can be used for multiple starts.

	$ cd dashing-docker
	$ sudo docker build -t viaplay/dashing .


### Start the container
The container has all pre requisites set up to run any dashing project. Which one is up to the mapped folder and how to start is up to the start.sh script. More about them later.

	$ sudo docker run -i -d -p 3030:3030 -v `pwd`/dashboard:/dashboard:ro viaplay/dashing

The startup time for this container is quite long so give it a short coffee break before trying the browser on url http://localhost:3030. The ruby bundle command takes some time to download all dependencies for the dashing project. 

*The -p 3030:3030 will occupy the 3030 port on your host which might not be preferred, in fact it is not recommended. This route has been taken to save explanation steps. Please read the docker documentation if you wish to change this.*

#### Start the container and keep control
The command above starts the container in deamon mode (-d) and runs in the background. If you want to start it by yourself just to see what happens use this command:

	$ sudo docker run -i -t -p 3030:3030 -v `pwd`/dashboard:/dashboard:ro viaplay/dashing bash

Notice the two changes made here, first we replaced the deamon switch (-d) with the tty switch (-t) which pipes the std in and std out to your terminal.

You now end up as a root user in the docker container and can do simple things like ls, cd and more. More complex things can be achieved after a `apt-get install` of one or more software(s) of choice.


### Stop the container
Stopping a running container is possible via the docker api. If only one instance of this container is running this command will stop it:

	sudo docker stop `sudo docker ps |grep viaplay/dashing-docker |cut -d\  -f1`



## Change the sample to your dashing project
It's as easy as pointing out another folder in the startup script. Change the path between the -v and the first colon to the folder where your dashing project lies. 

	$ sudo docker run -i -d -p 3030:3030 -v /your/path/to/dashing-proj:/dashboard:ro viaplay/dashing

Copy or rewrite the start.sh script in the sample dashboard folder, it has to be in your dashing folder. It's purpose is to activate the dashing service.

This is the default content of the start.sh file:

	cd dashboard
	bundle
	dashing start

You can also completely change the volume mapping but you have to change the start.sh accordingly.



## Use the docker image for development

If you feel ready to use the docker image for development you have to change `:ro` to `:rw` before starting it. This is in fact the way we made the sample dashing project. `dashing new dashboard`

	$ sudo docker run -i -t -p 3030:3030 -v `pwd`/dashboard:/dashboard:rw viaplay/dashing bash

