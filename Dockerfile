FROM testmycode/tmc-server-base:latest
LABEL name tmc-server

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --system --gemfile /app/Gemfile
ADD . /app
