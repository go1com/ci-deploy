FROM gitlab/dind

# Add nodejs repos + Install PHP CLI + Node.JS + Ruby + tools
RUN apt-get update && apt-get install -y language-pack-en-base software-properties-common && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php5-5.6 && curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get upgrade -y && apt-get install php5-cli php5-dev php5-curl php5-gd php5-mcrypt php5-bcmath php5-mysql php5-sqlite build-essential libmcrypt-dev libicu-dev libxml2-dev libssl-dev curl git-core unzip python2.7 jq g++ python-software-properties libfontconfig ruby-dev nodejs -y -qq && apt-get clean && rm -rf /var/lib/apt/lists/*
# Install mongo + mailparse
RUN pecl install mongo && pecl download mailparse-2.1.6 && tar -zxf mailparse-2.1.6.tgz && cd mailparse-2.1.6 && sed -i '/#if !HAVE_MBSTRING/c#if !HAVE_MBSTRING && false' mailparse.c && phpize && ./configure && make && make install
# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
# Enable mailparse + mongo + other extensions
RUN echo 'extension=mongo.so' > /etc/php5/cli/conf.d/10-mongo.ini && echo 'extension=mailparse.so' > /etc/php5/cli/conf.d/10-mailparse.ini && php5enmod mcrypt mysql sqlite

# Install tools (phpunit, phing)
RUN composer global require phpunit/phpunit:* &&  composer global require phing/phing:*
RUN ln -s ~/.composer/vendor/bin/phpunit /usr/local/bin/phpunit && ln -s ~/.composer/vendor/bin/phing /usr/local/bin/phing

# Install python + aws
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install awscli s3cmd

# Install compass + sass
RUN gem install --no-rdoc --no-ri compass foundation sass

# install nodejs + tools
RUN bash -c 'npm set progress=false' && bash -c 'npm install -g bower grunt-cli jira-cmd phantomjs-prebuilt utf-8-validate bufferutil optipng jpegtran pngquant gifsicle bufferutil jshint ycssmin recess selenium-standalone webdriver-manager' && selenium-standalone install --silent && webdriver-manager update

# Configure .ssh to skip validate the remote host key
RUN mkdir -p ~/.ssh
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

ENTRYPOINT ["wrapdocker"]
CMD []
