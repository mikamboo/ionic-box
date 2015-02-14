Ionic Box
=============================

Ionic Box is a ready-to-go hybrid deveopment environment for building mobile apps with Ionic, Cordova, and Android. Ionic Box was built to make it easier for developers to build Android versions of their app, and especially for Windows users to get a complete dev environment set up without all the headaches.

This fork (from [driftyco/ionic-box](https://github.com/driftyco/ionic-box)) uses Docker insead Vagrant to build and run the ionic-box. For vagrant method see the content of vagrant folder.


Requirements
=================

* [Docker](https://www.docker.com/) : Build, Ship and Run Any App, Anywhere


Usage : ionic-box
=================

    sudo docker run -it --rm --name ionic-box -p 8100:8100 -p 35729:35729 mikamboo/ionic-box

* App is running on [http://localhost:8100](http://localhost:8100)

If you have your own ionic sources, you can launch it with:

    sudo docker run -ti -p 8100:8100 -p 35729:35729 -v /path/to/your/ionic-project/:/myApp mikamboo/ionic-box /bin/bash

Enable USB for the container

    sudo docker run -ti -p 8100:8100 -p 35729:35729 --privileged -v /dev/bus/usb:/dev/bus/usb -v \$PWD:/myApp mikamboo/ionic-box adb list


