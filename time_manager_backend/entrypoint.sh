#!/bin/sh

DB_SERVICE_NAME=db
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=postgres

echo "Waiting for database service: $DB_SERVICE_NAME"
until PGPASSWORD=$DB_PASSWORD pg_isready -h $DB_SERVICE_NAME -U $DB_USER -d $DB_NAME; do
  echo "Waiting for database to be ready..."
  sleep 2
done

echo "Database is ready"

echo "Listing files in /app:"
ls -la /app

cd time_manager_backend

mix deps.get

# Créer et migrer la base de données
mix ecto.create
mix ecto.migrate

# Démarrer le serveur Phoenix
exec mix phx.server