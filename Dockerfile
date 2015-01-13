FROM centos:centos6

MAINTAINER Jeronimo Martinez Sanchez <jms@rz0r.net>

WORKDIR /root
USER root
ADD rbenv.sh /etc/drone.d/
ADD rbenv.sh /etc/profile.d/

# packages
RUN yum groupinstall -y "Development Tools"
RUN yum -y install openssl openssl-devel readline-devel readline libxml2-devel libxslt-devel libyaml-devel zlib zlib-devel git --enablerepo=centosplus

# rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# ruby install
RUN bash -lc 'export CC=gcc'
RUN bash -lc 'rbenv install 2.1.2'

# bundler
RUN bash -lc 'rbenv global 2.1.2; gem install rbenv-rehash'
RUN bash -lc 'rbenv global 2.1.2; gem install bundler'
RUN bash -lc 'export RBENV_VERSION=2.1.2'
RUN bash -lc 'rbenv rehash'
