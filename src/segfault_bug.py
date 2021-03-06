import os
import subprocess

import qgis.core as qgc


def _get_prefix_path():
    qgis_path = subprocess.run(
        ['which', 'qgis'],
        stdout=subprocess.PIPE
    ).stdout.decode('utf-8').strip('\n')

    qgis_prefix_path = os.path.abspath(os.path.join(qgis_path, '..', '..'))

    return qgis_prefix_path


def _init_qgis():
    qgs = qgc.QgsApplication([], False)
    qgs.initQgis()
    qgc.QgsApplication.setPrefixPath(_get_prefix_path(), True)

    return qgs


def trigger_with_vector():
    vector_path = '/tmp/populated_places.gpkg'
    result = qgc.QgsVectorLayer(
        vector_path,
        'vectorlayer',
        'ogr'
    )

    return result


def main():
    qgs = _init_qgis()

    vector_result = trigger_with_vector()
    print(vector_result)

    del vector_result
    qgs.exitQgis()


def main_without_cleanup():
    vector_result = trigger_with_vector()
    print(vector_result)
