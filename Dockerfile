FROM ruby:2.4.4-alpine3.7

ENV MY_UID=1000 MY_GID=1000

# install jekyll system dependencies
RUN apk add --no-cache --update bash g++ gcc git less libc-dev make sudo

# create a normal user with sudo access for installing packages later
# this normal user is also meant for development
RUN addgroup -g "${MY_GID:-1000}" webdev && \
adduser -h /home/webdev -G webdev -u "${MY_UID:-1000}" -D -s /bin/bash webdev && \
echo '%webdev ALL=NOPASSWD: ALL' >  /etc/sudoers.d/90webdev

# container init
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
echo "057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945  /usr/local/bin/dumb-init" | sha256sum -c - && \
chmod 755 /usr/local/bin/dumb-init
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

USER webdev
WORKDIR /home/webdev

# install website dependencies
COPY * /home/webdev/
RUN gem install bundler && bundle install

# default command
CMD jekyll serve
