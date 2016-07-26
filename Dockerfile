FROM gitlab/dind

# Add nodejs repos + Install PHP CLI + Node.JS + Ruby + tools
RUN apt-get update \
    && apt-get install -y language-pack-en-base software-properties-common \
    && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get upgrade -y \
    && apt-get install php5.6 php5.6-mbstring php5.6-soap php5.6-curl php-mongo php-mailparse php5.6-gd php5.6-mcrypt php5.6-bcmath php5.6-mysql php5.6-sqlite php5.6-xml libmcrypt-dev libicu-dev libxml2-dev libssl-dev curl git-core unzip python2.7 jq g++ python-software-properties libfontconfig build-essential ruby-dev nodejs -y -qq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install composer + tools + python + aws + amazon ecs cli + compass + sass
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require phpunit/phpunit:* \
    && composer global require phing/phing:* \
    && ln -s ~/.composer/vendor/bin/phpunit /usr/local/bin/phpunit \
    && ln -s ~/.composer/vendor/bin/phing /usr/local/bin/phing \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install awscli s3cmd \
    && curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
    && gem install --no-rdoc --no-ri compass foundation sass

# install nodejs + tools + configure .ssh to skip validate the remote host key
RUN bash -c 'npm set progress=false' \
    && bash -c 'npm install -g bower grunt-cli jira-cmd phantomjs-prebuilt utf-8-validate bufferutil optipng jpegtran pngquant gifsicle bufferutil jshint ycssmin recess selenium-standalone webdriver-manager' \
    && selenium-standalone install --silent \
    && webdriver-manager update \
    && mkdir -p ~/.ssh \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

ENTRYPOINT ["wrapdocker"]
CMD []
