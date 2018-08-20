FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y apt-transport-https gnupg wget openjdk-8-jre-headless
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&  apt-get install -y elasticsearch

WORKDIR /usr/share/elasticsearch

COPY --chown=elasticsearch:root assets/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
COPY --chown=elasticsearch:root assets/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh


# Openshift overrides USER and uses ones with randomly uid>1024 and gid=0
# Allow ENTRYPOINT (and ES) to run even with a different user
RUN chgrp 0 /usr/local/bin/docker-entrypoint.sh && \
    chmod g=u /etc/passwd && \
    chmod 0775 /usr/local/bin/docker-entrypoint.sh

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-user-agent
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-geoip

# fix perms
RUN chown -R elasticsearch:elasticsearch /etc/elasticsearch
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins/

EXPOSE 9200 9300

USER elasticsearch
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# Dummy overridable parameter parsed by entrypoint
CMD ["eswrapper"]
