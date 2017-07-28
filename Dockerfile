FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         python-pip \
         python-dev \
         python-setuptools \
         cmake \
         git \
         curl \
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
     /opt/conda/bin/conda install ipython jupyter scikit-learn pandas matplotlib

RUN git clone https://github.com/pytorch/pytorch.git && cd pytorch && git checkout ac76ab5fca3734a94b41006969621039e8b72387

RUN CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" /bin/bash -c "source /opt/conda/bin/activate  && \
    conda install numpy pyyaml mkl setuptools cmake gcc cffi && \
    conda install -c soumith magma-cuda80 && \
    cd pytorch && python setup.py install"

RUN /opt/conda/bin/pip install --upgrade --ignore-installed https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.2.1-cp35-cp35m-linux_x86_64.whl
RUN apt-get update && apt-get install -y wget
