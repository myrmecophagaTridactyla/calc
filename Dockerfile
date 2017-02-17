FROM java

COPY scripts/run.sh /run.sh
RUN chmod +x /run.sh

COPY target/scala-2.10/calc-assembly-0.1.jar /bs.jar
COPY client/components /client/components

CMD ["/run.sh"]

EXPOSE 8080
