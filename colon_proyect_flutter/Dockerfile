# Usa una imagen base que ya incluya todas las dependencias necesarias
FROM ubuntu:22.04

# Instalar dependencias necesarias, incluyendo OpenJDK 11 y otras herramientas
RUN apt-get update && apt-get install -y \
    curl \
    file \
    git \
    wget \
    unzip \
    xz-utils \
    libglu1-mesa \
    openjdk-11-jdk \
    libc6 \
    libstdc++6 \
    libgcc1 \
    zlib1g \
    libncurses5 \
    libbz2-1.0 \
    qemu-user-static \
    && rm -rf /var/lib/apt/lists/*



RUN apt-get clean

WORKDIR /usr/local
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.2-stable.tar.xz
RUN tar xf flutter_linux_3.19.2-stable.tar.xz
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

WORKDIR /tmp
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
RUN unzip commandlinetools-linux-9477386_latest.zip
RUN rm commandlinetools-linux-9477386_latest.zip
RUN mkdir -p /usr/lib/android-sdk/cmdline-tools/latest
RUN mv cmdline-tools/* /usr/lib/android-sdk/cmdline-tools/latest
ENV PATH="${PATH}:/usr/lib/android-sdk/cmdline-tools/latest/bin"

RUN git config --global --add safe.directory /usr/local/flutter
# RUN flutter channel stable
# RUN flutter upgrade

RUN yes | sdkmanager \
    "platform-tools" \
    "platforms;android-28" \
    "platforms;android-29" \
    "platforms;android-30" \
    "platforms;android-31" 
RUN yes | sdkmanager --licenses
RUN flutter precache
RUN flutter doctor -v



RUN mkdir /app
WORKDIR /app/

CMD ["tail", "-f", "/dev/null"]













































