# Day 2: Load Balancer Infrastructure Setup

## 🎯 Project Overview

Built a complete load balancer infrastructure using Flask, Docker, and NGINX to demonstrate distributed web services and traffic management.

---

## 📁 Project Structure

```
load-balancer-infra/
├── app.py                  # Flask web application
├── Dockerfile             # Container configuration
├── docker-compose.yml     # Multi-container orchestration
├── nginx.conf            # Load balancer configuration
├── requirements.txt      # Python dependencies
└── v-env/               # Virtual environment
```

---

## 🚀 What I Built

### 1. Flask Web Application (`app.py`)

A Python web server with three endpoints:

- **`/`** - Homepage with visual container identification
- **`/health`** - JSON health check endpoint
- **`/metrics`** - Server metadata and statistics

**Key Features:**
- Shows container hostname to visualize load balancing
- Beautiful gradient UI with status indicators
- Timestamp tracking for request monitoring
- Configurable server names via environment variables

### 2. Docker Configuration

**Single Container Setup:**
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
EXPOSE 8000
CMD ["python", "app.py"]
```

**Multi-Container Orchestration (`docker-compose.yml`):**
- 3 Flask app instances (web1, web2, web3)
- 1 NGINX load balancer
- Round-robin traffic distribution
- Health checks enabled

### 3. NGINX Load Balancer

Configured upstream servers with:
- Round-robin algorithm
- Health monitoring
- Proper error handling
- Request forwarding with headers

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Flask** | Python web framework |
| **Docker** | Containerization |
| **Docker Compose** | Multi-container orchestration |
| **NGINX** | Load balancer / reverse proxy |
| **Python 3.12** | Runtime environment |
| **Werkzeug** | WSGI utility library |

---

## 💻 Commands & Usage

### Setup Virtual Environment
```bash
# Create virtual environment
python3 -m venv v-env

# Activate it
source v-env/bin/activate

# Install dependencies
pip install flask
```

### Run Single Instance
```bash
python3 app.py
# Visit: http://localhost:8000
```

### Run with Docker
```bash
# Build image
docker build -t flask-app .

# Run container
docker run -p 8000:8000 \
  -e SERVER_NAME="Production Server" \
  flask-app
```

### Run Load Balanced Setup
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Testing Endpoints
```bash
# Homepage
curl http://localhost

# Health check
curl http://localhost/health

# Metrics
curl http://localhost/metrics

# Test load balancing (run multiple times)
for i in {1..10}; do curl -s http://localhost | grep "Container ID"; done
```

---

## 🐛 Issues Faced & Solutions

### 1. Neovim LSP Import Errors ❌
**Problem:** Pyright LSP showing "Module not found" for Flask imports

**Root Cause:** LSP couldn't find Flask in virtual environment

**Solution:**
```bash
# Created pyrightconfig.json in project root
{
  "venvPath": ".",
  "venv": "v-env"
}
```
```vim
" Restarted LSP in Neovim
:LspRestart
```

### 2. null-ls Configuration Error ❌
**Problem:** `Invalid server name 'null-ls'` error in Neovim

**Root Cause:** Using archived `null-ls` instead of maintained `none-ls` fork

**Solution:**
- Updated plugin to `nvimtools/none-ls.nvim`
- Kept `require("null-ls")` (drop-in replacement)
- Commented out `stylua` formatter (not needed for Python)

### 3. Missing Formatters ❌
**Problem:** `command stylua is not executable` error

**Solution:**
```bash
# Installed Python formatters
pip install black isort pylint

# Commented out stylua in init.lua (Lua-specific)
-- none_ls.builtins.formatting.stylua,
```

---

## 📚 What I Learned

### Technical Skills
1. **Flask Framework Basics**
   - Routing and decorators
   - JSON responses
   - Environment variables
   - Template rendering

2. **Docker & Containerization**
   - Writing Dockerfiles
   - Multi-stage builds
   - Container networking
   - Docker Compose orchestration

3. **Load Balancing Concepts**
   - Round-robin algorithm
   - Health checks
   - Upstream configuration
   - Reverse proxy setup

4. **Neovim LSP Configuration**
   - Understanding Language Server Protocol
   - Pyright configuration
   - Virtual environment detection
   - Plugin management with lazy.nvim

### Problem-Solving
- Debugging LSP configuration issues
- Reading error messages effectively
- Using `pcall` for safe Lua configuration
- Researching package deprecation (null-ls → none-ls)

---

## 🎓 Key Concepts

### Load Balancing
- **Purpose:** Distribute traffic across multiple servers
- **Benefits:** High availability, scalability, fault tolerance
- **Algorithm Used:** Round-robin (sequential distribution)

### Containerization Benefits
- **Isolation:** Each service runs independently
- **Reproducibility:** Same environment everywhere
- **Scalability:** Easy to add more instances
- **Portability:** Run anywhere Docker runs

### Health Checks
- Monitor service availability
- Automatic failover
- Request routing decisions
- Performance monitoring

---

## 🔧 Configuration Files

### `requirements.txt`
```
flask==3.1.2
werkzeug==3.1.5
```

### `pyrightconfig.json` (Neovim LSP)
```json
{
  "venvPath": ".",
  "venv": "v-env"
}
```

---

## 📈 Next Steps

### Improvements to Implement
- [ ] Add request metrics and monitoring
- [ ] Implement session persistence (sticky sessions)
- [ ] Add SSL/TLS termination
- [ ] Create logging aggregation
- [ ] Add performance benchmarking
- [ ] Implement weighted load balancing
- [ ] Add database connection pooling
- [ ] Create automated health monitoring dashboard

### Advanced Features
- [ ] Kubernetes deployment
- [ ] Auto-scaling configuration
- [ ] Circuit breaker pattern
- [ ] Rate limiting
- [ ] API gateway integration
- [ ] Distributed tracing
- [ ] Prometheus metrics export

---

## 📊 Testing Results

```bash
# Load balancing verification (10 requests)
$ for i in {1..10}; do curl -s http://localhost | grep "Container ID"; done

Container ID: web1-abc123
Container ID: web2-def456
Container ID: web3-ghi789
Container ID: web1-abc123
Container ID: web2-def456
Container ID: web3-ghi789
Container ID: web1-abc123
Container ID: web2-def456
Container ID: web3-ghi789
Container ID: web1-abc123

✅ Perfect round-robin distribution confirmed!
```

---

## 🎯 Skills Demonstrated

- ✅ Python web development (Flask)
- ✅ RESTful API design
- ✅ Docker containerization
- ✅ Container orchestration (Docker Compose)
- ✅ Load balancer configuration (NGINX)
- ✅ System architecture design
- ✅ Debugging and troubleshooting
- ✅ Development environment setup (Neovim + LSP)
- ✅ Version control practices
- ✅ Documentation writing

---

## 🤔 Reflection

Today was all about understanding distributed systems fundamentals. The most valuable lesson wasn't just getting the load balancer working—it was debugging the development environment (Neovim LSP issues) and understanding how modern IDEs detect Python environments.

The `null-ls` → `none-ls` migration taught me to always check if packages are actively maintained, and the Pyright configuration showed me how LSPs actually work under the hood.

Building this from scratch (rather than using a tutorial) forced me to read documentation, understand error messages, and think through the architecture logically.

---

## 📝 Resources Used

- [Flask Documentation](https://flask.palletsprojects.com/)
- [Docker Documentation](https://docs.docker.com/)
- [NGINX Load Balancing Guide](https://nginx.org/en/docs/http/load_balancing.html)
- [Pyright Configuration Docs](https://github.com/microsoft/pyright/blob/main/docs/configuration.md)
- [none-ls.nvim GitHub](https://github.com/nvimtools/none-ls.nvim)

---

## 👨‍💻 Author

**Day 2 of Infrastructure Learning Journey**

Built with 💙 using Flask, Docker, and a lot of debugging!

---

## 📄 License

MIT License - Feel free to use this for learning purposes!

---

**Date:** February 10, 2026  
**Project Duration:** ~4 hours (including debugging)  
**Lines of Code:** ~150 (Python + Config files)  
**Containers Deployed:** 4 (3 apps + 1 load balancer)
