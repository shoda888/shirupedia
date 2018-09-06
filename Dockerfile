# ruby 2.5.0のイメージを使う
FROM ruby:2.5.0

# rails consoleで日本語を使う
ENV LANG C.UTF-8

# ROOT_PATH変数設定
ENV ROOT_PATH /shirupedia

# ディレクトリ作成
RUN mkdir $ROOT_PATH

# 必要なライブラリインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https postgresql-client

# Yarnをインストール
# https://yarnpkg.com/en/docs/install#linux-tab
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.jsをインストール(webpackerに必要)
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install nodejs

# gem
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4 --retry=3 --path vendor/bundler

# 全ファイルコピー
WORKDIR $ROOT_PATH
COPY . $ROOT_PATH

# yarn
RUN yarn install --update-checksums