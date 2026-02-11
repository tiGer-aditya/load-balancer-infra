# Day 3: Nginx Load Balancer ✅

## What I Built
- Nginx reverse proxy and load balancer
- Port mapping to access from Windows browser (localhost:8080)
- Round-robin load balancing between 2 Flask servers
- Automatic failover when servers go down
- Health check endpoint for Nginx
- Test scripts for validation

## Architecture
```
Windows Browser (localhost:8080)
         ↓
    Nginx Load Balancer (port 80)
         ↓
    ┌────────┴────────┐
    ↓                 ↓
Web Server 1      Web Server 2
(Flask:8000)      (Flask:8000)
```

## Tech Stack
- **Load Balancer:** Nginx (Alpine)
- **Algorithm:** Round-robin (default)
- **Port Mapping:** 8080:80

## Nginx Configuration
```nginx
upstream backend {
    server web-server-1:8000;
    server web-server-2:8000;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
    }
}
```

## Load Balancing Algorithms Tested

### Round-Robin (Default)
- Distributes requests evenly
- Request 1 → Server 1, Request 2 → Server 2
- Best for similar server capacity

### Least Connections
```nginx
upstream backend {
    least_conn;
    server web-server-1:8000;
    server web-server-2:8000;
}
```
- Routes to server with fewest active connections
- Best for long-running requests

### IP Hash
```nginx
upstream backend {
    ip_hash;
    server web-server-1:8000;
    server web-server-2:8000;
}
```
- Same client always goes to same server
- Best for session persistence

## Testing Results

### Load Balancing Test
✅ 5 requests distributed evenly  
✅ Servers alternate correctly  
✅ Both servers receiving traffic  

### Failover Test
✅ Server 1 stopped → All traffic to Server 2  
✅ Server 1 restarted → Traffic resumes to both  
✅ Zero downtime during failover  

### Health Checks
✅ Server 1: 200 OK  
✅ Server 2: 200 OK  
✅ Nginx health endpoint: OK  

## Key Commands
```bash
# Build and start
docker-compose up -d --build

# Test load balancing
./scripts/test-loadbalancer.sh

# Test failover
./scripts/test-failover.sh

# View nginx logs
docker-compose logs nginx

# Reload nginx config (no downtime)
docker exec nginx-lb nginx -s reload
```

## What I Learned
- Nginx reverse proxy configuration
- Load balancing algorithms and use cases
- Port mapping in Docker
- High availability and failover
- Proxy headers (X-Real-IP, X-Forwarded-For)
- Automated testing with bash scripts

## Skills Demonstrated
✅ Nginx configuration  
✅ Load balancing strategies  
✅ High availability design  
✅ Port mapping and networking  
✅ Automated testing  
✅ Zero-downtime deployments  

## Interview Talking Points
- "I configured Nginx as a reverse proxy to distribute traffic across multiple backend servers"
- "Implemented automatic failover - if one server fails, traffic routes to healthy servers"
- "Used Docker port mapping to expose the load balancer on localhost:8080"
- "Created test scripts to validate load distribution and failover scenarios"

## Next: Day 4
Build Python monitoring dashboard to track all services in real-time
