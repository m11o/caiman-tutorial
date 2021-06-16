FROM continuumio/anaconda3

RUN apt-get update
RUN apt-get install -y build-essential wget vim libgl1-mesa-dev

ENV APP_ROOT /caiman
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD ./CaImAn $APP_ROOT

RUN conda env create -f environment.yml -n caiman
RUN echo "conda activate caiman" >> /root/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

RUN pip install -e .

RUN python caimanmanager.py install --inplace
