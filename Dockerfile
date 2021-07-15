FROM public.ecr.aws/lambda/nodejs:latest

LABEL maintainer="Rajan Panneer Selvam <rajan.india@yahoo.co.in>"

RUN yum install -y amazon-linux-extras
RUN amazon-linux-extras enable corretto8
RUN yum install java-1.8.0-amazon-corretto -y
RUN yum install tar -y

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
    && rm -rf /tmp/data

ENV PATH $PATH:$JMETER_BIN

WORKDIR ${TESTS_ROOT}

COPY . ${TESTS_ROOT}

COPY app.js ${LAMBDA_TASK_ROOT}
CMD [ "app.handler" ]