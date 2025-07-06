FROM mcr.microsoft.com/dotnet/sdk:9.0

ENV DEBIAN_FRONTEND=noninteractive

# Install webhook and sudo
RUN apt-get update \
 && apt-get install -y webhook sudo \
 && rm -rf /var/lib/apt/lists/*

# Create ki6bjv user (no password) with password-less sudo
RUN useradd -m -s /bin/bash ki6bjv \
 && passwd -d ki6bjv \
 && usermod -aG sudo ki6bjv \
 && echo "ki6bjv ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ki6bjv \
 && chmod 0440 /etc/sudoers.d/ki6bjv

# Prepare the app dir
RUN mkdir -p /home/ki6bjv/bot \
 && chown -R ki6bjv:ki6bjv /home/ki6bjv

EXPOSE 9000

USER ki6bjv
WORKDIR /home/ki6bjv/bot

# Run webhook on startup
ENTRYPOINT ["webhook", "-hooks", "hooks.yaml", "-verbose", "-hotreload", "-secure", "-urlprefix", ""]