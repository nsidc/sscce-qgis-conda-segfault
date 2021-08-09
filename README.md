Attempt at an
[SSCCE](https://docs.google.com/document/d/14svLZT5yzSW07VWKFABLvUcjIntwBZa2uQokTTMTsoc/edit)
reproducing a segmentation fault using pyQGIS.

All versions after QGIS v3.10 began segfaulting with our existing code after
upgrade. We believe it's an issue with conda packaging because we can't
reproduce it on the official QGIS Docker image.


# Using

Run any of the services in the docker compose file to reproduce with various
combinations of conditions:

Environment: Official docker image; official docker image with conda installed (no environments); official docker image using qgis installed by conda.

Cleanup: Initializing and exiting a `qgis` session/object and manually `del`ing all layers; only creating layers

```
docker-compose run official_env_with_cleanup
docker-compose run official_env_without_cleanup
docker-compose run official_env_conda_installed_with_cleanup
docker-compose run official_env_conda_installed_without_cleanup
docker-compose run conda_env_with_cleanup
docker-compose run conda_env_without_cleanup
```

# Example output

```
$ docker-compose run official_env_with_cleanup
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```

```
$ docker-compose run official_env_without_cleanup
Application path not initialized
Application path not initialized
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```

```
$ docker-compose run official_env_conda_installed_with_cleanup
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```

```
$ docker-compose run official_env_conda_installed_without_cleanup
Application path not initialized
Application path not initialized
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```

```
$ docker-compose run conda_env_with_cleanup
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```

```
$ docker-compose run conda_env_without_cleanup
Application path not initialized
Application path not initialized
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```
