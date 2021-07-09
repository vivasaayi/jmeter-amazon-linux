FROM public.ecr.aws/lambda/java:8

LABEL maintainer="Rajan Panneer Selvam <rajan.india@yahoo.co.in>"

ARG JMETER_VERSION="5.4.1"

ENV TESTS_ROOT /tests
ENV JMETER_ROOT /jmeter
ENV JMETER_HOME /jmeter/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://mirror.nodesdirect.com/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN mkdir /jmeter

RUN mkdir -p /tmp/data \
    &&curl -L ${JMETER_DOWNLOAD_URL} > /tmp/data/apache-jmeter-${JMETER_VERSION}.tgz \
    && tar -xzf /tmp/data/apache-jmeter-${JMETER_VERSION}.tgz -C ${JMETER_ROOT} \
    && rm -rf /tmp/data \
    && mkdir p /tmp/out

ENV PATH $PATH:$JMETER_BIN
ENV JMETER_OUTPUT_PATH /tmp/out

WORKDIR ${TESTS_ROOT}

COPY . ${TESTS_ROOT}

ENTRYPOINT ["sh", "run_test.sh"]