FROM centos:centos6

MAINTAINER Jeronimo Martinez Sanchez <jms@rz0r.net>

WORKDIR /root
USER root

# packages
# RUN yum groupinstall -y "Development Tools"
RUN yum -y install autoconf gcc openssl openssl-devel readline-devel readline libxml2-devel libxslt-devel libyaml-devel libffi-devel zlib zlib-devel gdbm-devel ncurses-devel git --enablerepo=centosplus

# rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ADD rbenv.sh /etc/drone.d/
ADD rbenv.sh /etc/profile.d/

# ruby install
ENV CONFIGURE_OPTS --disable-install-doc
RUN bash -lc 'export CC=gcc'
RUN bash -lc 'rbenv install 2.1.5'

# bundler
RUN echo 'gem: --no-rdoc --no-ri' >> .gemrc
RUN bash -lc 'rbenv global 2.1.5; gem install rbenv-rehash'
RUN bash -lc 'rbenv global 2.1.5; gem install bundler'
RUN bash -lc 'export RBENV_VERSION=2.1.5'
RUN bash -lc 'rbenv rehash'
