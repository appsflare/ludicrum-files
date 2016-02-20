FROM node:4.3.0
MAINTAINER Srinath Janakiraman <me@vjsrinath.com>

ENV VERSION=1.0.1

ENV WORK_DIR=/srv/www/ludicrum-files

ENV PORT=4000
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV DB_HOST=orientdb
ENV DB_PORT=2424
ENV DB_NAME=ludicrum

ENV THUMBNAIL_DIR=/srv/tmp/ludicrum-files/thumbnails/
## ENV NODE_ENV

## Expose port 4000
EXPOSE ${PORT}


##RUN apt-get install build-essential libavahi-compat-libdnssd-dev
#install ffmpeg
RUN apt-get update \
    && apt-get install software-properties-common \
    && add-apt-repository ppa:kirillshkrogalev/ffmpeg-next \
    && apt-get update \
    && apt-get install ffmpeg;

##Creating working directory
RUN mkdir -p ${WORK_DIR} \
    && mkdir -p ${THUMBNAIL_DIR};

##Setting working directory
WORKDIR ${WORK_DIR}

##Copy package file to working directory
COPY package.json ./
##Install dependencies defined in package file
RUN npm install
##Copy rest of the files to working directory
COPY [".", "./"]

##Set the entry point to node
ENTRYPOINT ["node"]
##Set the arguments to be passed to the entrypoint
CMD ["app.js"]
