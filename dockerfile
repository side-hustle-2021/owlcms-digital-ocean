FROM openjdk:11-jre-slim-buster

COPY ./ /owlcms
WORKDIR /owlcms

ARG OWLCMS_JAR_URL

RUN addgroup   --system --gid 1001 appuser
RUN adduser  --system --uid  1001   --group appuser
ADD $OWLCMS_JAR_URL /owlcms/owlcms.jar 
RUN chown -R appuser:appuser /owlcms/
USER appuser

EXPOSE 8080
CMD java -jar /owlcms/owlcms.jar
