FROM ubuntu:hirsute

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y \
    wget \
    sudo \
    gnupg \
    software-properties-common

# Create new user
RUN useradd --user-group --create-home --shell /bin/bash cfd ;\
    echo "cfd ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Add repo for OpenFoam
RUN sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key | apt-key add -"
RUN sudo add-apt-repository http://dl.openfoam.org/ubuntu

# Install OpenFoam 9
RUN sudo apt-get update -y && sudo apt-get install -y openfoam9

RUN echo "source /opt/openfoam9/etc/bashrc" >> /home/cfd/.bashrc

USER cfd
