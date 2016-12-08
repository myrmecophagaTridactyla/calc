FROM java
MAINTAINER Gregorio Ortelli "gregorio.ortelli@gmail.com"

ENV DB_DBNAME books
ENV DB_COLLECTION books
ENV DB_HOST localhost

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY target/scala-2.10/source-assembly-0.1.jar /bs.jar
COPY client/components /client/components

CMD ["/run.sh"]

EXPOSE 8080
