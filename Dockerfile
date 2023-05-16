FROM node:slim

RUN apt-get update && apt-get install curl unzip -y --silent

VOLUME /app

ADD run.sh /run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]
