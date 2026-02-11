#!/bin/bash

echo "========================================"
echo "Failover Testing Script"
echo "========================================"
echo ""

echo "1. Testing with both servers..."
for i in {1..3}; do
  server=$(curl -s http://localhost:8080 | grep -o "Web Server [12]")
  echo "   Request $i → $server"
done

echo ""
echo "2. Stopping Server 1..."
docker stop web-server-1
sleep 2

echo ""
echo "3. Testing with only Server 2..."
for i in {1..3}; do
  server=$(curl -s http://localhost:8080 | grep -o "Web Server [12]")
  echo "   Request $i → $server"
done

echo ""
echo "4. Starting Server 1 again..."
docker start web-server-1
sleep 3

echo ""
echo "5. Testing with both servers restored..."
for i in {1..3}; do
  server=$(curl -s http://localhost:8080 | grep -o "Web Server [12]")
  echo "   Request $i → $server"
done

echo ""
echo "=========================================="
echo "✅ Failover test complete!"
echo "=========================================="
