#!/bin/bash

# Define environment variables for PostgreSQL
export PGPASSWORD=$DB_PASSWORD

# Backup the PostgreSQL database using pg_dump
echo "Backing up PostgreSQL database..."
mkdir -p /backups
pg_dump -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -F c -f "/backups/database_backup_$(date +\%Y-\%m-\%d).dump"

# Check if PostgreSQL backup was successful
if [ $? -eq 0 ]; then
    echo "PostgreSQL backup completed successfully!"
else
    echo "PostgreSQL backup failed."
    exit 1
fi

