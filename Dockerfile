FROM continuumio/anaconda3

RUN apt-get update && apt-get install -y gcc g++ libgl1

ENV APP_ROOT /caiman
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD ./CaImAn $APP_ROOT

RUN conda env create -f environment.yml -n caiman
RUN echo "conda activate caiman" >> /root/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

RUN conda install --override-channels -c conda-forge -n caiman pip
RUN /bin/bash -c "/opt/conda/envs/caiman/bin/pip install ."
RUN /bin/bash -c "caimanmanager.py install"
