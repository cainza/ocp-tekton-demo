FROM registry.redhat.io/openjdk/openjdk-11-rhel7

ENV JAVA_APP_JAR pipelinesdemo.jar
ENV AB_ENABLED off
ENV AB_JOLOKIA_AUTH_OPENSHIFT true

EXPOSE 8080

# Copy artifact
COPY target/pipelinesdemo.jar /deployments/

# Replace S2I comamnd by adding springboot options
CMD ["/usr/local/s2i/run"]