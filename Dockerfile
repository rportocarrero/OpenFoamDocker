FROM ubuntu:jammy
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
    wget \
    sudo \
    gnupg \
    software-properties-common \
    tzdata

# Create new user
RUN useradd --user-group --create-home --shell /bin/bash cfd ;\
    echo "cfd ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Add repo for OpenFoam
RUN sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key | apt-key add -"
RUN sudo add-apt-repository http://dl.openfoam.org/ubuntu

# Install OpenFoam 10
RUN sudo apt-get update -y && sudo apt-get install -y openfoam10

RUN echo "source /opt/openfoam10/etc/bashrc" >> /home/cfd/.bashrc

USER cfd
