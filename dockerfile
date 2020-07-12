FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
SHELL ["/bin/bash", "-c"]

LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libnccl2 \
         libnccl-dev \
         python-qt4 \
         libjpeg-dev \
	 zip \
	 unzip \
         python3-dev \
         python3-lxml \
         libxml2 \
         libxml2-dev \
         libxslt-dev \
         libyajl2 \
         gcc \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
# keras still not officially compatible with 3.7 as of 02/2019
ENV PYTHON_VERSION=3.6

RUN curl -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build

RUN mkdir /data
RUN chmod -R a+w /data
WORKDIR /data

ENV PATH=$PATH:/opt/conda/bin:$PATH
ENV USER ckai

# create environment
COPY environment.yml environment.yml
RUN conda env create -f environment.yml
RUN conda clean -ya

ENV PATH=$PATH:/opt/conda/envs/ckai/bin:$PATH

# activate source
CMD conda activate ckai
CMD source activate ckai

CMD source ~/.bashrc

# quick fix for environment.yml issues
CMD echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
#RUN source activate ckai && \
#    conda install --yes -c fragcolor cuda10.0 && \
#    conda install --yes pytorch torchvision cudatoolkit=10.0 -c pytorch
RUN source activate ckai

# Set the password for Jupyter Notebook
# run 'from notebook.auth import passwd; passwd()' in colab
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.password='sha1:8f18384f7144:962790076495570dc4a234010a4340c4c659785c'">>/root/.jupyter/jupyter_notebook_config.py

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
