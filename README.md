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
No protocol specified
qt.qpa.xcb: could not connect to display :0
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

$ echo $?
139
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
qt.qpa.xcb: could not connect to display
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

$ echo $?
139
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
qt.qpa.xcb: could not connect to display
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

$ echo $?
139
```

```
$ docker-compose run conda_env_without_cleanup
Application path not initialized
Application path not initialized
<QgsVectorLayer: 'vectorlayer' (ogr)>
$ echo $?
0
```
