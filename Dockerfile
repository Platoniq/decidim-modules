FROM ruby:3.1.1

ENV DEBIAN_FRONTEND=noninteractive \
    RAILS_ENV=production \
    BUNDLE_WITHOUT=development:test \
    BUNDLE_DEPLOYMENT=true \
    BUNDLE_PATH=/usr/local/bundle

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    zlib1g-dev \
    p7zip \
    wkhtmltopdf \
    libpq-dev \
    libicu-dev \
    imagemagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install 

COPY package.json /app
COPY package-lock.json /app
RUN npm ci

COPY . /app
RUN RAILS_ENV=production SECRET_KEY_BASE=build bin/rails assets:precompile

RUN rm -rf node_modules tmp/cache && \
    apt-get autoremove -y && apt-get clean

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

