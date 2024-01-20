FROM node:18-alpine
WORKDIR /app
COPY  /front/app/package.json .
RUN npm install -g pnpm
RUN pnpm install
COPY ./front .
EXPOSE 8000
ENV NODE_ENV=production

CMD ["pnpm", "dev"]
