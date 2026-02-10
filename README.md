# Load Balancer Infrastructure

Production-ready load balancer with Flask, Nginx, and Docker - built as a portfolio project for SysAdmin/Network Admin roles.

## 🎯 Project Goal
Demonstrate enterprise infrastructure skills by building a complete load-balanced web application from scratch.

## 🏗️ Architecture (Final)
```
Windows Browser (localhost:8080)
         ↓
    Nginx Load Balancer
         ↓
    ┌────────┴────────┐
    ↓                 ↓
Flask Server 1    Flask Server 2
(Gunicorn)        (Gunicorn)
    ↓                 ↓
    Monitoring Dashboard
```

## 📊 Progress Tracker
- [x] **Day 1**: Docker setup & networking ✅
- [x] **Day 2**: Flask web servers with health checks ✅
- [ ] **Day 3**: Nginx load balancer configuration
- [ ] **Day 4**: Python monitoring dashboard
- [ ] **Day 5**: Automation scripts & logging
- [ ] **Day 6**: Testing & optimization
- [ ] **Day 7**: Final polish & deployment guide

## 🛠️ Tech Stack
- **Containers:** Docker & Docker Compose
- **Load Balancer:** Nginx
- **Web Apps:** Python Flask + Gunicorn
- **Monitoring:** Python + Flask Dashboard
- **OS:** Ubuntu 24.04 on WSL2

## 🚀 Quick Start
```bash
# Clone repository
git clone git@github.com:YOUR_USERNAME/load-balancer-infra.git
cd load-balancer-infra

# Start all services
docker-compose up -d

# Check status
docker ps

# View logs
docker-compose logs

# Stop services
docker-compose down
```

## 📁 Project Structure
```
load-balancer-infra/
├── docker-compose.yml       # Service orchestration
├── web-servers/
│   ├── requirements.txt     # Python dependencies
│   ├── server-1/
│   │   ├── app.py          # Flask application
│   │   └── Dockerfile
│   └── server-2/
│       ├── app.py
│       └── Dockerfile
├── docs/
│   ├── day1-setup.md       # Docker networking
│   └── day2-flask-servers.md  # Flask apps
└── README.md
```

## 💡 What I'm Learning
- Docker containerization & networking
- Load balancing strategies
- Production web server deployment (Gunicorn)
- REST API design (health checks, metrics)
- Infrastructure automation
- System monitoring

## 🎓 Skills Demonstrated
✅ Docker & Docker Compose  
✅ Python web development (Flask)  
✅ Nginx configuration  
✅ Load balancing  
✅ Network architecture  
✅ Production deployment  
✅ Container security (non-root users)  
✅ System administration  
✅ Technical documentation  

## 📝 Documentation
- [Day 1: Docker Setup & Networking](docs/day1-setup.md)
- [Day 2: Flask Web Servers](docs/day2-flask-servers.md)

## 🔗 Connect
Building this for SysAdmin/Network Admin portfolio.

## 📄 License
MIT
