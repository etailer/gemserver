FROM rjocoleman/alpine-s3fs:ruby2

RUN apk add --update \
 build-base \
 git \
 bash \
 mysql-dev \
 sqlite-dev \
 postgresql-dev; \
 rm -rf /var/cache/apk/*; \
 gem update --system;

# Create a ~/.gemstash/config.yml.erb file filled with ENV variables
# This allows configuration via ENV (and means `$ gemstash setup` won't work)
RUN mkdir -p /root/.gemstash; \
 \
 echo $'--- \n\
 <% if ENV.has_key? "BASE_PATH" %>:base_path: <%= ENV["BASE_PATH"] %><% end %>\n\
 <% if ENV.has_key? "CACHE_TYPE" %>:cache_type: <%= ENV["CACHE_TYPE"] %><% end %>\n\
 <% if ENV.has_key? "MEMCACHED_SERVERS" %>:memcached_servers: <%= ENV["MEMCACHED_SERVERS"] %><% end %>\n\
 <% if ENV.has_key? "DB_ADAPTER" %>:db_adapter: <%= ENV["DB_ADAPTER"] %><% end %>\n\
 <% if ENV.has_key? "DB_URL" %>:db_url: <%= ENV["DB_URL"] %><% end %>\n\
 <% if ENV.has_key? "RUBYGEMS_URL" %>:rubygems_url: <%= ENV["RUBYGEMS_URL"] %><% end %>\n\
 <% if ENV.has_key? "BIND" %>:bind: <%= ENV["BIND"] %><% end %>' > /root/.gemstash/config.yml.erb;

RUN git clone https://github.com/bundler/gemstash /tmp/gemstash; \
 cd /tmp/gemstash; \
 gem build gemstash.gemspec; \
 gem install --no-ri --no-rdoc gemstash-*.gem; \
 gem install --no-ri --no-rdoc pg mysql mysql2;

ENV RACK_ENV production

WORKDIR /root/.gemstash

EXPOSE 9292
# Start a server as the default command
CMD ["gemstash", "start", "--no-daemonize"]
