#!/bin/sh

RUN mix deps.get
RUN mix ecto.create
RUN mix ecto.migrate
RUN mix phx.server
RUN mix phx.swagger.generate