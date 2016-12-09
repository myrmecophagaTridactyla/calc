FROM java
MAINTAINER Gregorio Ortelli "gregorio.ortelli@gmail.com"

FROM debian:jessie
MAINTAINER Gregorio Ortelli "gregorio.ortelli@gmail.com"

RUN apt-get update

# CUrl
RUN apt-get -y install curl

# Dependencies
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list

# NodeJS, Git, SBT, xvfb
RUN apt-get clean && apt-get update && \
    apt-get -y --fix-missing install wget bzip2 make g++ && \
    apt-get -y --force-yes --fix-missing install --no-install-recommends nodejs git sbt xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Scala
RUN curl -O -q http://downloads.typesafe.com/scala/2.11.5/scala-2.11.5.deb && \
    dpkg -i scala-2.11.5.deb && \
    rm scala-2.11.5.deb

# Gulp, bower
RUN npm install -g gulp bower

# Dirs
RUN mkdir /source
RUN mkdir -p /data/db

ADD project /source/project
ADD build.sbt /source/build.sbt
ADD client/bower.json /source/client/bower.json
ADD client/gulpfile.js /source/client/gulpfile.js
ADD client/package.json /source/client/package.json
ADD client/wct.conf.js /source/client/wct.conf.js
ADD run_tests.sh /source/run_tests.sh

RUN chmod +x /source/run_tests.sh

# Dependencies
RUN cd /source && sbt update
RUN cd /source/client && npm install && bower install --allow-root --config.interactive=false -s

# Envs
ENV TEST_TYPE "spec"
ENV DOMAIN "http://172.17.42.1"
ENV DISPLAY ":1.0"
ENV DB_HOST localhost

ENV DB_DBNAME books
ENV DB_COLLECTION books
ENV DB_HOST localhost

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY target/scala-2.10/calc-assembly-0.1.jar /bs.jar
COPY client/components /client/components

CMD ["/run.sh"]

EXPOSE 8080
