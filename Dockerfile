FROM java

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
    apt-get -y --force-yes --fix-missing install --no-install-recommends nodejs git xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Gulp, bower
RUN npm install -g bower

# Dirs
RUN mkdir /source

ADD project /source/project
ADD build.sbt /source/build.sbt
ADD client/bower.json /source/client/bower.json
ADD client/gulpfile.js /source/client/gulpfile.js
ADD client/package.json /source/client/package.json
ADD client/wct.conf.js /source/client/wct.conf.js

# Dependencies
RUN cd /source/client && npm install && bower install --allow-root --config.interactive=false -s
RUN npm run deps

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY target/scala-2.10/calc-assembly-0.1.jar /bs.jar
COPY client/components /client/components

CMD ["/run.sh"]

EXPOSE 8080
