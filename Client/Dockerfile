FROM node:18.12-alpine

WORKDIR /Client

COPY . .

RUN npm install -g pnpm

RUN pnpm install
RUN pnpm run build

EXPOSE 5173

CMD ["pnpm", "run", "dev", "--host"]
