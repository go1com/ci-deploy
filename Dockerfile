FROM gitlab/dind

# Install PHP CLI + tools
RUN apt-get update && apt-get upgrade -y && apt-get install php5-cli php5-dev php5-curl build-essential libmcrypt-dev libicu-dev libxml2-dev libssl-dev curl git-core unzip python2.7 -y -qq && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pecl install mongo
RUN pecl download mailparse-2.1.6 && tar -zxf mailparse-2.1.6.tgz && cd mailparse-2.1.6 && sed -i '/#if !HAVE_MBSTRING/c#if !HAVE_MBSTRING && false' mailparse.c && phpize && ./configure && make && make install
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN php5enmod curl mailparse mongo

# Install python + aws
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install awscli

ENTRYPOINT ["wrapdocker"]
CMD []
