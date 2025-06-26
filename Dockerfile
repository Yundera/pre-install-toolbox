FROM alpine:latest

# Install curl and wget
RUN apk add --no-cache openssl curl wget xxd

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]