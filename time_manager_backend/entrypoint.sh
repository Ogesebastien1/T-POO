#!/bin/sh

cd time_manager_backend
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server