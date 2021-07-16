FROM amazonlinux

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
    && rm -rf /tmp/data \
    && mkdir p /tmp/out \
    && cd ${JMETER_HOME}/lib \
    && curl -O https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.2/cmdrunner-2.2.jar \
    && cd ${JMETER_HOME}/lib/ext \
    && curl -O https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/1.6/jmeter-plugins-manager-1.6.jar 

RUN java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-1.6.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
    && ${JMETER_HOME}/bin/PluginsManagerCMD.sh install-all-except \
        jpgc-casutg, \
        jpgc-autostop, \
        ubik-jmeter-autocorrelator-plugin \
        ubik-jmeter-gwt-plugin \
        ubik-jmeter-videostreaming-plugin

ENV PATH $PATH:$JMETER_BIN
ENV JMETER_OUTPUT_PATH /tmp/out

WORKDIR ${TESTS_ROOT}

COPY . ${TESTS_ROOT}

# ENTRYPOINT ["sh", "run_test.sh"]