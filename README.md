# Docker Elasticsearch Ubuntu

[![Automated Build](https://img.shields.io/docker/automated/phihos/elasticsearch-ubuntu.svg)](https://hub.docker.com/r/phihos/elasticsearch-ubuntu/)
[![Docker Build Status](https://img.shields.io/docker/build/phihos/elasticsearch-ubuntu.svg)](https://hub.docker.com/r/phihos/elasticsearch-ubuntu/)

Elasticsearch Docker image with based on Ubuntu Linux.

## Why

The official Elasticsearch image has moved away from Docker Hub into another registry. There we have no *latest* tag for images.
Also currently no option exists for installing plugins and running the container in one go.
This image attempts to provide an up-to-date version of Elasticsearch on Docker Hub with automated builds while maintaining compliance with the official image docs.

## Usage

The entrypoint script is a slightly modified version from the official image.
For instructions on how to use this image visit the [elasticsearch image docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html).

### Install Plugins

For plugin installation and running Elasticsearch in one command use a comma separated list in the environment
variable ```ES_PLUGINS``` like this:

```
docker run -e ES_PLUGINS=discovery-file,ingest-attachment phihos/elasticsearch-ubuntu
```

### Data Directory

Opposed to the official volume the data directory is located in ```/var/lib/elasticsearch```.
