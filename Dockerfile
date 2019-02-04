FROM openjdk:8u171-jre-alpine3.8

ENV OKTA_VERSION=1.0.8
ENV OKTA_RELEASE=https://github.com/oktadeveloper/okta-aws-cli-assume-role/releases/download/v${OKTA_VERSION}/okta-aws-cli-${OKTA_VERSION}.jar

# install aws cli
RUN apk add --update --no-cache python py-pip git curl make bash
RUN pip install awscli --upgrade

# move okta jar into bin
RUN curl -sSL ${OKTA_RELEASE} > /usr/bin/okta-aws-cli.jar

# create a auto assume wrapper
COPY awscli /usr/bin/awscli

# set as default command
CMD ["awscli"]
