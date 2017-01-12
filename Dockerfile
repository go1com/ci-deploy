FROM ubuntu:xenial

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.12.3
ENV DOCKER_SHA256 626601deb41d9706ac98da23f673af6c0d4631c4d194a677a9a1a07d7219fa0f

RUN apt-get update -qq && apt-get install -qqy \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
    && set -x \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v \
    && curl -s -L https://github.com/docker/compose/releases/latest | \
        egrep -o '/docker/compose/releases/download/[0-9.]*/docker-compose-Linux-x86_64' | \
        wget --base=http://github.com/ -i - -O /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && /usr/local/bin/docker-compose --version \
    && apt-get install -qqy language-pack-en-base software-properties-common \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get update -qq  \
    && apt-get install -qqy php php-mbstring php-soap php-curl php-mongodb php-gd php-mcrypt php-bcmath php-mysql php-sqlite3 php-xml libmcrypt-dev libicu-dev libxml2-dev libssl-dev curl git-core unzip python2.7 jq g++ python-software-properties libfontconfig build-essential ruby-dev nodejs \
    && apt-get clean -qqy \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require phpunit/phpunit:* \
    && composer global require phing/phing:* \
    && ln -s ~/.composer/vendor/bin/phpunit /usr/local/bin/phpunit \
    && ln -s ~/.composer/vendor/bin/phing /usr/local/bin/phing \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install awscli s3cmd docker-cloud \
    && curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
    && chmod +x /usr/local/bin/ecs-cli \
    && gem install --no-rdoc --no-ri compass foundation sass \
    && bash -c 'npm set progress=false' \
    && bash -c 'npm install -g yarn bower grunt-cli jira-cmd phantomjs-prebuilt utf-8-validate bufferutil optipng jpegtran pngquant gifsicle bufferutil jshint ycssmin recess selenium-standalone webdriver-manager imagemin imagemin-gifsicle imagemin-jpegtran imagemin-optipng imagemin-pngquant newman serverless' \
    && selenium-standalone install --silent \
    && webdriver-manager update \
    && mkdir -p ~/.ssh \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
