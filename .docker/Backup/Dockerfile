FROM ubuntu:latest

# Install required dependencies
RUN apt-get update && \
    apt-get install -y cron postgresql-client-16 curl tar
    

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Copy the backup and restore scripts
COPY .docker/Backup/backup.sh ./

# Set permissions for the scripts
RUN chmod +x  ./backup.sh 

# Set the default command to run the cron job
CMD ["./backup.sh"]
