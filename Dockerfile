FROM ubuntu:14.04.2

MAINTAINER mike@mikangali.com

# Install basics 
RUN apt-get update &&  \
    apt-get install -y npm git wget curl && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \
    apt-get clean

COPY tools /opt/tools

# Install PhamtomJs (Ubuntu fix)
RUN ["/opt/tools/install-phantomjs.sh"]

# Install npm packages
RUN npm install -g cordova ionic@1.3.18
RUN npm install -g grunt-cli
RUN npm install -g gulp
RUN npm install -g bower

RUN ionic start ionic-demo sidemenu

# Expose port: web (8100), livereload (35729)
EXPOSE 8100 35729

#ANDROID
#JAVA
ENV DEBIAN_FRONTEND noninteractive
# install python-software-properties (so you can do add-apt-repository)
RUN apt-get update && apt-get install -y -q python-software-properties software-properties-common && apt-get clean

# install oracle java from PPA
RUN add-apt-repository ppa:webupd8team/java -y
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update && apt-get -y install oracle-java7-installer && apt-get clean

#ANDROID STUFF
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect ant wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 qemu-kvm kmod && apt-get clean

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
ENV PATH ${PATH}:/opt/tools

RUN echo ANDROID_HOME="${ANDROID_HOME}" >> /etc/environment

RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21.1.2,android-19,addon-google_apis_x86-google-19,extra-android-support,extra-android-m2repository,extra-google-m2repository,sys-img-x86-android-21"]


WORKDIR ionic-demo
CMD ["ionic", "serve", "8100", "35729"]
