FROM openjdk:8u201-jre-alpine3.9

ENV OKTA_VERSION=1.0.10
ENV OKTA_RELEASE=https://github.com/oktadeveloper/okta-aws-cli-assume-role/releases/download/v${OKTA_VERSION}/okta-aws-cli-${OKTA_VERSION}.jar

# install aws cli
RUN apk add --update --no-cache python3 git curl make bash
RUN pip3 install --upgrade pip
RUN pip3 install awscli

# move okta jar into bin
RUN curl -sSL ${OKTA_RELEASE} > /usr/bin/okta-aws-cli.jar

# create a auto assume wrapper
COPY awscli /usr/bin/awscli

# set as default command
CMD ["awscli"]
