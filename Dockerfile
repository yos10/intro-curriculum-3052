FROM --platform=linux/x86_64 node:14.15.4-slim as base
RUN apt-get update
RUN apt-get install -y locales vim tmux
RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
ENV TZ Asia/Tokyo
ENV NODE_ENV=production
RUN mkdir /home/node/app && chown node:node /home/node/app
WORKDIR /home/node/app
USER node
COPY --chown=node:node package.json ./
RUN yarn install --ignore-optional && yarn cache clean

FROM base as dev
ENV NODE_ENV=development
RUN yarn install --ignore-optional && yarn cache clean
