FROM ubuntu


WORKDIR /root

# stop apt-get from opening dialogues during build
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    wget nano julia qt5-default python3-pip


RUN pip3 install jupyterlab
RUN apt-get install -y nodejs
RUN pip3 install --upgrade jupyterlab jupyterlab-git
RUN jupyter lab build

# julia packages installation is divided in multiple parts
# to leverage more easily docker caching of image layers

# install julia packages (1)
COPY ./julia/install_packages.jl /root/build/julia/
RUN julia /root/build/julia/install_packages.jl

# install julia packages (2)
COPY ./julia/install_packages2.jl /root/build/julia/
RUN julia /root/build/julia/install_packages2.jl


## NOT PERMANENT STUFF

COPY ./ssh /root/.ssh/
RUN eval `ssh-agent -s` && ssh-add /root/.ssh/id_rsa

# install OpenAIGym personal repo
RUN git clone git@github.com:FeLusiani/gym.git
# install python packages in Conda.jl environment
RUN /root/.julia/conda/3/bin/pip install /root/gym/ Box2D

# install python packages in Conda.jl environment
# RUN apt-get install cmake
# RUN /root/.julia/conda/3/bin/pip install /root/gym/[atari]


# clone JuliaRL personal repo
RUN git clone git@github.com:FeLusiani/JuliaRL.git

# WORKDIR ./JuliaRL

# COPY ./julia/install_Reinforce.jl /root/build/julia/
# for some reason Pkg.develop does not set this env var correctly
# ENV JULIA_PKG_DEVDIR='./dev'
# RUN julia /root/build/julia/install_Reinforce.jl

# disable jupyter auto save (no more checkpoints files)
RUN mkdir -p /root/.jupyter/custom
RUN echo "Jupyter.notebook.set_autosave_interval(0);" >> /root/.jupyter/custom/custom.js

# remove stuff
RUN apt-get clean
#remove leftovers
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

