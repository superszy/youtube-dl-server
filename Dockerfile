#
# youtube-dl Server Dockerfile
#
# https://github.com/manbearwiz/youtube-dl-server-dockerfile
#

FROM python:alpine

RUN apk add --no-cache \
  ffmpeg \
  tzdata

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN apk --update-cache add --virtual build-dependencies gcc libc-dev make g++

RUN pip install --no-cache-dir -r requirements.txt
  
RUN apk del build-dependencies

COPY . /usr/src/app

EXPOSE 8080

VOLUME ["/youtube-dl"]

RUN ln -s /usr/local/bin/yt-dlp /usr/local/bin/youtube-dl

CMD [ "python", "-u", "./youtube-dl-server.py" ]
