FROM ubuntu

user root

ENV DEBIAN_FRONTEND=newt

# RUN useradd -m react
# RUN usermod -aG sudo react

# apt-get update
RUN apt-get update -qq && apt-get install -y build-essential

# essentials
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y git

# for ssh
RUN apt-get install -y openssh-server
RUN /etc/init.d/ssh start
RUN update-rc.d ssh start

# for wkhtmltopdf
#RUN apt-get install -y software-properties-common python-software-properties
#RUN add-apt-repository -y ppa:pov/wkhtmltopdf
#RUN apt-get update -qq
RUN apt-get install -y wkhtmltopdf

# for java
RUN apt-get install -y default-jre
RUN apt-get install -y default-jdk

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

# for MySQL
RUN apt-get install -y mysql-server
RUN service mysql start
RUN update-rc.d mysql start


# for postgres
RUN apt-get install -y postgresql postgresql-contrib
RUN service postgresql start
RUN update-rc.d postgresql start


ENV APP_HOME /sites
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#ADD Gemfile* $APP_HOME/
#RUN bundle install

# for SSH in port 2222
EXPOSE 2222:22

# for rails
EXPOSE 3000:3000

# for MySQL
EXPOSE 3306:3306

# for PostgreSQL
EXPOSE 5432:5432
EXPOSE 5433:5433


ADD . $APP_HOME

# USER react
# for RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
CMD source /home/react/.rvm/scripts/rvm
CMD rvm install 1.9.3
CMD rvm use 1.9.3
CMD gem install bundler
CMD rvm install 2.1.3
CMD rvm use 2.1.3
CMD gem install bundler
CMD rvm --default use 2.1.3