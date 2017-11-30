FROM docker:latest

RUN \
    mkdir -p /aws && \
    apk -Uuv add curl groff less python py-pip && \
    pip install awscli && \
    curl -o /usr/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest && \
    chmod a+x /usr/bin/ecs-cli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*
