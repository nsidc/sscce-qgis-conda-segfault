FROM qgis/qgis:release-3_16 AS qgis-only 

WORKDIR /

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y wget

COPY ./src ./

CMD ["python3", "src/test_with_cleanup.py"]



FROM qgis-only AS qgis-plus-conda

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p
RUN rm ~/miniconda.sh

CMD ["python3", "src/test_with_cleanup.py"]



FROM qgis-plus-conda as qgis-in-conda-env

COPY ./environment.yml /
RUN /bin/bash -c "source ~/miniconda3/bin/activate && conda env create -f /environment.yml"

CMD ./src/run_in_conda.sh python src/test_with_cleanup.py
