FROM openjdk:14-jdk-alpine3.10

LABEL Creator="Elio Severo Junior"
LABEL Email="elioseverojunior@gmail.com"
LABEL Application="OpenTest"
LABEL Type="APITests"

EXPOSE 3000

ENV TESTENV=_local
ENV WORKSPACE=/home/opentest
ENV LOGDIR=/home/opentest/logs
ENV TESTREPORTDIR=${WORKSPACE}/out
ENV TESTREPORT=${TESTREPORTDIR}/open_tests_report.xml
ENV DEBUG=0
# DEBUG=0 = TURN OFF DEBUG MODE
# DEBUG=1 = TURN ON DEBUG MODE

RUN apk add --no-cache \
    curl \
    jq \
    python \
    python-dev \
    py-pip \
    build-base \ 
    nodejs \
    npm \
    vim
    
RUN pip install dicttoxml
RUN pip install virtualenv
RUN npm install opentest -g --silent --unsafe
RUN rm -rf /var/cache/apk/*

RUN mkdir -p ${LOGDIR} \
  mkdir -p ${TESTREPORTDIR}

WORKDIR ${WORKSPACE}

COPY src/. .

RUN chmod +x ${WORKSPACE}/run-opentest.sh