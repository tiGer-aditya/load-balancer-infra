FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/nginx.conf

# Copy our custom config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Nginx runs as root by default (standard practice for nginx)
CMD ["nginx", "-g", "daemon off;"]
