FROM node:20-slim AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app

COPY . .

RUN npm install -g pnpm

RUN pnpm install

EXPOSE 8080

CMD ["pnpm", "run", "dev"]