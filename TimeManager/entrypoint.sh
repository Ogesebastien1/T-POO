#!/bin/sh

cd TimeManager
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
mix phx.swagger.generate