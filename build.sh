#!/bin/bash
podman build . -t docker.io/meuna/lsdc2:satisfactory --format docker \
&& podman push docker.io/meuna/lsdc2:satisfactory