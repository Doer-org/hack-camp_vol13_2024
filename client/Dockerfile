FROM node:20.5.1
WORKDIR /usr/src
COPY ./client /usr/src
RUN yarn install
CMD ["sh", "-c", "yarn dev"]
