LABEL maintainer="Combiz Khozoie, Ph.D. FullName@hotmail.com"

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libnccl2=2.0.5-3+cuda9.0 \
         libnccl-dev=2.0.5-3+cuda9.0 \
         python-qt4 \
         libjpeg-dev \
	 zip \
	 unzip \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION=3.6
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build

RUN mkdir /data
WORKDIR /data

COPY environment.yml environment.yml
COPY /courses/ /data/courses/

RUN ls && /opt/conda/bin/conda env create
RUN /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/envs/ckai/bin:$PATH
ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV USER ckai

CMD source activate ckai
CMD source ~/.bashrc

RUN chmod -R a+w /data

# Set the password for Jupyter Notebook
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.password='sha1:a9bb67abddaa:0a644122b5f4522258307d6d612c212bd3915a69'">>/root/.jupyter/jupyter_notebook_config.py

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
