FROM elixir:latest

RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.5.1

WORKDIR /app

COPY . .

RUN mix deps.get

RUN mix deps.compile

COPY entrypoint.sh .

RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get

EXPOSE 4000

ENTRYPOINT ["sh", "time_manager_backend/entrypoint.sh"]

CMD ["mix", "phx.server"]