FROM continuumio/miniconda3:4.10.3

WORKDIR /

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y wget

COPY ./src ./
COPY environment.yml ./

RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx

RUN conda env create -f environment.yml
