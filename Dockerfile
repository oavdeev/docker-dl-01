FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         python-pip \
         python-dev \
         python-qt4 \
         python-setuptools \
         cmake \
         git \
         curl \
         wget \
         ssh \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip


RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install conda-build && \
     /opt/conda/bin/conda install ipython jupyter scikit-learn pandas matplotlib tqdm

RUN /opt/conda/bin/conda install -c oavdeev -c soumith pytorch==0.2.0.post1 torchvision cuda80
