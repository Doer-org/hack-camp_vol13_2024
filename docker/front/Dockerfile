FROM node:14-alpine
WORKDIR /app
COPY ./client/package*.json ./
RUN npm install -g pnpm
RUN pnpm install
COPY ./Front .
EXPOSE 8000
ENV NODE_ENV=production

CMD ["pnpm", "dev"]
