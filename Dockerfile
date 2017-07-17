FROM ubuntu:xenial

RUN apt-get update -qq && apt-get install -yqq \
        apt-transport-https \
        ca-certificates \
        curl \
        language-pack-en-base \
        lxc \
        software-properties-common \
    && set -x \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" \
    && apt-get update \
    && apt-get install docker-ce -yqq \
    && docker -v \
    && curl -s -L https://github.com/docker/compose/releases/latest | \
        egrep -o '/docker/compose/releases/download/[0-9.]*/docker-compose-Linux-x86_64' | \
        wget --base=http://github.com/ -i - -O /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && /usr/local/bin/docker-compose --version \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x kubectl && mv kubectl /usr/local/bin/kubectl \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get update -qq  \
    && apt-get install -qqy php php-mbstring php-soap php-curl php-mongodb php-gd php-mcrypt php-bcmath php-mysql php-sqlite3 php-xml libmcrypt-dev libicu-dev libxml2-dev libssl-dev curl git-core unzip python2.7 jq g++ python-software-properties libfontconfig build-essential ruby-dev nodejs gettext default-jre default-jdk \
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
    && bash -c 'npm config set -g progress false' \
    && bash -c 'npm install -g bower yarn @angular/cli grunt-cli gulp-cli jira-cmd phantomjs-prebuilt utf-8-validate bufferutil optipng jpegtran pngquant gifsicle bufferutil jshint ycssmin recess selenium-standalone webdriver-manager imagemin imagemin-gifsicle imagemin-jpegtran imagemin-optipng imagemin-pngquant optipng-bin jpegtran-bin newman nightmare mocha serverless serverless-webpack webpack node-sass typescript' \
    && selenium-standalone install --silent \
    && webdriver-manager update \
    && mkdir -p ~/.ssh \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
