FROM openjdk:8-jdk-stretch

ENV SELENIUM_BINARY_PATH /usr/bin/selenium.jar

ENV PHANTOM_BINARY_PATH /usr/bin/phantomjs

ENV SELENIUM_JAR selenium-server-standalone-3.4.0.jar

ENV PHANTOM_VERSION phantomjs-2.1.1-linux-x86_64

ENV no_proxy "localhost;127.0.0.1"

# Update and install Phantom required libs
RUN apt-get update; \
  apt-get install -y build-essential chrpath libssl-dev libxft-dev; \
  apt-get install -y libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev; \
  apt-get install -y curl wget software-properties-common;

# Install Nodejs and Nightwatch
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -; \
  apt-get install -y nodejs; \
  npm install -g nightwatch@0.9.16

# Install Selenium
RUN wget https://selenium-release.storage.googleapis.com/3.4/$SELENIUM_JAR; \
  mv $SELENIUM_JAR /usr/local/share; \
  ln -s /usr/local/share/$SELENIUM_JAR /usr/bin/selenium.jar

# Install Phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_VERSION.tar.bz2; \
  tar xjf $PHANTOM_VERSION.tar.bz2; \
  mv $PHANTOM_VERSION/bin/phantomjs /usr/local/share; \
  rm -rf $PHANTOM_VERSION; \
  ln -s /usr/local/share/phantomjs /usr/bin/phantomjs
