from flask import Flask, jsonify
import socket
import os
from datetime import datetime

app = Flask(__name__)

SERVER_NAME = os.getenv("SERVER_NAME", "Web Server")


@app.route("/")
def home():
    hostname = socket.gethostname()

    html = """
    <html>
    <head>
        <title>{server}</title>
        <style>
            body {{
                font-family: Arial, sans-serif;
                text-align: center;
                padding: 50px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                margin: 0;
            }}
            .container {{
                background: white;
                color: #333;
                padding: 40px;
                border-radius: 15px;
                max-width: 600px;
                margin: 0 auto;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }}
            h1 {{ 
                color: #667eea; 
                font-size: 2.5em;
                margin-bottom: 20px;
            }}
            .info {{
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin: 20px 0;
            }}
            .info p {{
                margin: 10px 0;
                font-size: 1.1em;
            }}
            .status {{
                display: inline-block;
                background: #28a745;
                color: white;
                padding: 8px 20px;
                border-radius: 20px;
                margin-bottom: 20px;
            }}
            .endpoints {{
                background: #e9ecef;
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
                font-size: 0.9em;
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <h1>✓ {server}</h1>
            <div class="status">🟢 ONLINE</div>
            
            <div class="info">
                <p><strong>Container ID:</strong> {host}</p>
                <p><strong>Timestamp:</strong> {time}</p>
            </div>

            <div class="endpoints">
                <strong>Available Endpoints:</strong><br>
                GET / | GET /health | GET /metrics
            </div>
            
            <p style="margin-top: 30px; color: #666;">
                🔄 <strong>Refresh this page</strong> to see load balancing in action!
            </p>
        </div>
    </body>
    </html>
    """

    return html.format(
        server=SERVER_NAME,
        host=hostname,
        time=datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    )


@app.route("/health")
def health():
    return (
        jsonify(
            {
                "status": "healthy",
                "server": SERVER_NAME,
                "hostname": socket.gethostname(),
                "timestamp": datetime.now().isoformat(),
            }
        ),
        200,
    )


@app.route("/metrics")
def metrics():
    return (
        jsonify(
            {
                "server": SERVER_NAME,
                "hostname": socket.gethostname(),
                "endpoints": ["/", "/health", "/metrics"],
                "status": "operational",
            }
        ),
        200,
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=False)
