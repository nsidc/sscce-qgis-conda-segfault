FROM qgis/qgis:release-3_16 AS qgis-only 
RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y wget

COPY ./segfault_bug.py /
COPY ./run_system.sh /
COPY ./test_with_cleanup.py /.
COPY ./test_without_cleanup.py /.

CMD ["python3", "test_with_cleanup.py"]



FROM qgis-only AS qgis-plus-conda

COPY ./run_in_conda.sh /

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p
RUN rm ~/miniconda.sh

CMD ["python3", "test_with_cleanup.py"]



FROM qgis-plus-conda as qgis-in-conda-env

COPY ./environment.yml /

RUN /bin/bash -c "source ~/miniconda3/bin/activate && conda env create -f /environment.yml"


COPY ./populated_places.gpkg /tmp/populated_places.gpkg

ENTRYPOINT ["./run_in_conda"]
CMD ["python3", "test_with_cleanup.py"]
