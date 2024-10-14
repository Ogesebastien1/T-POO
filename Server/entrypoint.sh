#!/bin/sh

cd /app
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
mix phx.swagger.generate