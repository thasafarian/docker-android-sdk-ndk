FROM openjdk:8-jdk

MAINTAINER Hafni Syaeful Sulun <hafni.syaeful.sulun@gmail.com>

ENV ANDROID_SDK_TOOLS_REV="4333796" \
    ANDROID_CMAKE_REV="3.6.4111459" \
    ANDROID_CMAKE_REV_3_10="3.10.2.4988404"

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools/:${ANDROID_NDK_HOME}:${ANDROID_HOME}/ndk-bundle:${ANDROID_HOME}/tools/bin/

RUN apt-get update && \
    apt-get install -y file && \
    rm -rf /var/lib/apt/lists/*

RUN    mkdir -p ${ANDROID_HOME} \
    && wget --quiet --output-document=${ANDROID_HOME}/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip \
    && unzip -qq ${ANDROID_HOME}/android-sdk.zip -d ${ANDROID_HOME} \
    && rm ${ANDROID_HOME}/android-sdk.zip \
    && mkdir -p $HOME/.android \
    && echo 'count=0' > $HOME/.android/repositories.cfg

RUN    yes | sdkmanager --licenses > /dev/null \ 
    && yes | sdkmanager --update \
    && yes | sdkmanager 'tools' \
    && yes | sdkmanager 'platform-tools' \
    && yes | sdkmanager 'build-tools;29.0.3' 'build-tools;30.0.2' \
    && yes | sdkmanager 'platforms;android-28' 'platforms;android-29' 'platforms;android-30' \
    && yes | sdkmanager 'extras;android;m2repository' \
    && yes | sdkmanager 'extras;google;google_play_services' \
    && yes | sdkmanager 'extras;google;m2repository' 
    && yes | sdkmanager 'cmake;3.10.2.4988404' \
    && yes | sdkmanager 'ndk;21.0.6113669' 'ndk;21.1.6352462' 'ndk;21.2.6472646' 'ndk;21.3.6528147'
