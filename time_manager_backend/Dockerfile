FROM elixir:latest

# Install debian packages
RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.5.1

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

# Set the working directory
WORKDIR /app



# Install ping command
RUN apt-get update && apt-get install -y iputils-ping

# Install PostgreSQL client
RUN apt-get install -y postgresql-client

# Copy the Elixir project
COPY . .

RUN mix deps.get

RUN mix deps.compile

COPY entrypoint.sh .

RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get

RUN ls

EXPOSE 4000

ENTRYPOINT ["sh", "time_manager_backend/entrypoint.sh"]

CMD ["mix", "phx.server"]