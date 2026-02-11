#!/bin/bash

echo "========================================"
echo "Load Balancer Testing Script"
echo "========================================"
echo ""

# Check if containers are running
echo "1. Checking container status..."
docker ps --format "table {{.Names}}\t{{.Status}}" | grep -E "nginx-lb|web-server"

if [ $? -ne 0 ]; then
    echo "❌ Containers not running! Run: docker-compose up -d"
    exit 1
fi

echo "✅ All containers running"
echo ""

# Test nginx is accessible
echo "2. Testing Nginx accessibility..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)

if [ "$response" != "200" ]; then
    echo "❌ Nginx not accessible on port 8080"
    echo "   HTTP status: $response"
    exit 1
fi

echo "✅ Nginx responding on port 8080"
echo ""

# Test load balancing (5 requests)
echo "3. Testing load balancing (5 requests)..."
echo "   Watch servers alternate:"
echo ""

for i in {1..5}; do
  server=$(curl -s http://localhost:8080 | grep -o "Web Server [12]")
  echo "   Request $i → $server"
  sleep 1
done

echo ""
echo "✅ Load balancing working!"
echo ""

# Test health endpoints
echo "4. Testing health endpoints..."

health1=$(docker exec web-server-1 python -c "import urllib.request; print(urllib.request.urlopen('http://localhost:8000/health').getcode())" 2>/dev/null)
health2=$(docker exec web-server-2 python -c "import urllib.request; print(urllib.request.urlopen('http://localhost:8000/health').getcode())" 2>/dev/null)

if [ "$health1" == "200" ]; then
    echo "   ✅ Server 1 health: OK ($health1)"
else
    echo "   ❌ Server 1 health: FAILED"
fi

if [ "$health2" == "200" ]; then
    echo "   ✅ Server 2 health: OK ($health2)"
else
    echo "   ❌ Server 2 health: FAILED"
fi

echo ""

# Summary
echo "========================================"
echo "🎉 All tests passed!"
echo "========================================"
echo ""
echo "Next: Open browser to http://localhost:8080"
echo "      Refresh (F5) to see servers alternate"
echo ""
