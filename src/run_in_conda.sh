#!/usr/bin/env bash
_CONDA_ROOT='/root/miniconda3'
\. "$_CONDA_ROOT/etc/profile.d/conda.sh" || return $?
conda activate test-qgis-segfault

echo "$@"
$@
