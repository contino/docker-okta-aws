FROM openjdk:8u171-jre-alpine3.8

ENV OKTA_VERSION=1.0.4
ENV OKTA_RELEASE=https://github.com/oktadeveloper/okta-aws-cli-assume-role/releases/download/v${OKTA_VERSION}/okta-aws-cli-${OKTA_VERSION}.jar

# install aws cli
RUN apk add --update --no-cache python py-pip git curl make
RUN pip install awscli --upgrade

# move okta jar into bin
RUN curl -sSL ${OKTA_RELEASE} > /usr/bin/okta-aws-cli.jar

# create a wrapper to call all aws commands via okta and make executable
RUN echo -e '#!/bin/sh\njava -classpath /usr/bin/okta-aws-cli.jar com.okta.tools.awscli $@' > /usr/bin/awscli
RUN chmod a+x /usr/bin/awscli
