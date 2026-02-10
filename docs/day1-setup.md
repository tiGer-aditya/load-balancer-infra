# Day 1: Docker Setup & Networking ✅

## What I Built
- Installed Docker & Docker Compose on WSL2
- Created custom Docker network (`loadbalancer-net`)
- Deployed 2 test containers running Python HTTP server
- Verified container-to-container communication

## Tech Stack
- Ubuntu 24.04 on WSL2
- Docker & Docker Compose
- Python 3.11 base image

## docker-compose.yml
```yaml
version: '3.8'

services:
  web1:
    image: python:3.11-slim
    container_name: web-server-1
    command: python -m http.server 8000
    networks:
      - app-network

  web2:
    image: python:3.11-slim
    container_name: web-server-2
    command: python -m http.server 8000
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
    name: loadbalancer-net
```

## Key Commands
```bash
# Start containers
docker-compose up -d

# Check status
docker ps

# View logs
docker-compose logs

# Test communication
docker exec web-server-1 ping -c 3 web-server-2

# Stop containers
docker-compose down
```

## Issues Fixed
- **Permission denied**: Added user to docker group, restarted WSL
- **Slow attach in WSL2**: Use detached mode (`-d` flag)
- **No curl in container**: Use Python's urllib instead

## What I Learned
- Docker networking basics
- Container communication via service names
- Docker Compose vs Docker commands
- WSL2 best practices (detached mode)

## Testing Results
✅ Containers running  
✅ Network communication working  
✅ Logs showing HTTP requests  
✅ Service discovery functional  

## Next: Day 2
Build custom Flask applications with health endpoints
