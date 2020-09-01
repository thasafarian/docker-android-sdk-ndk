FROM openjdk:8-jdk

MAINTAINER Hafni Syaeful Sulun <hafni.syaeful.sulun@gmail.com>

ENV ANDROID_HOME=/opt/android-sdk
ENV CMDLINE_TOOLS_DIR=$ANDROID_HOME/cmdline-tools
ENV PATH $PATH:$CMDLINE_TOOLS_DIR/tools/bin

RUN apt-get update && \
    apt-get install -y file && \
    rm -rf /var/lib/apt/lists/*

RUN    mkdir -p $CMDLINE_TOOLS_DIR \
    && wget --quiet --output-document=$CMDLINE_TOOLS_DIR/cmd-line-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip \
    && unzip -qq $CMDLINE_TOOLS_DIR/cmd-line-tools.zip -d $CMDLINE_TOOLS_DIR \
    && rm $CMDLINE_TOOLS_DIR/cmd-line-tools.zip

RUN    yes | sdkmanager --licenses > /dev/null \
    && yes | sdkmanager "tools" \
    && yes | sdkmanager "platform-tools" \
    && yes | sdkmanager "build-tools;29.0.3" "build-tools;30.0.2" \
    && yes | sdkmanager "platforms;android-29" "platforms;android-30" \
    && yes | sdkmanager "extras;android;m2repository" \
    && yes | sdkmanager "extras;google;google_play_services" \
    && yes | sdkmanager "extras;google;m2repository" \
    && yes | sdkmanager "cmake;3.10.2.4988404" \
    && yes | sdkmanager "ndk;21.3.6528147"
