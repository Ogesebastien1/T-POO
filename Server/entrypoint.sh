#!/bin/sh
cd 
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
mix phx.swagger.generate