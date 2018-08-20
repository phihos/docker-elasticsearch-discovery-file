# Docker Elasticsearch Ubuntu

Elasticsearch Docker image with based on Ubuntu Linux.

## Why

The official Elasticsearch image has moved away from docker hub into another registry. There we hvae no *latest* tag for images.
Also currently no option exists for installing plgins and running the container in one go.
This image attempts to provide an up-to-date version of Elasticsearch on Dockerhub with automated builds while maintaining compliance with the offial image docs.

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