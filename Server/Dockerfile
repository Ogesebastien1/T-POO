FROM elixir:latest

RUN apt-get update && apt-get install -y \
    iputils-ping \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.5.1

WORKDIR /app

COPY . .

RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get

RUN mix deps.get
RUN mix ecto.create
RUN mix ecto.migrate
RUN mix phx.server
RUN mix phx.swagger.generate

EXPOSE 4000

CMD ["mix", "phx.server"]