# Learning from beevelop, thanks beevelop!

FROM amostsai/webupd8java
MAINTAINER Amos Tsai <amos.tsai@gmail.com>


ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    ANDROID_BUILD_TOOLS_VERSION=25.0.2 \
    ANDROID_APIS="android-19,android-20,android-21,android-22,android-23,android-24,android-25" \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/usr/share/gradle" \
    ANDROID_HOME="/opt/android-sdk-linux"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qq install -y curl ant gradle libncurses5:i386 libstdc++6:i386 zlib1g:i386 bsdtar && \

    # Installs Android SDK
    curl -sL ${ANDROID_SDK_URL} | bsdtar -xf- -C /opt && \
    echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME && \

    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean
