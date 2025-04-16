# 🕒 Simple Time Service

A lightweight Python Flask application that returns the current UTC timestamp and the IP address of the visitor. It is containerized using Docker and served via **Gunicorn** on port **80**.

Public Hosted Image ID: "vijay49m/simple-time-service:1.0.0"

---

## 📁 Project Structure

```
.
├── app.py                 # Flask application
├── gunicorn-config.py    # Gunicorn server configuration
├── requirements.txt      # Python dependencies
├── start.sh              # Shell script to start Gunicorn
└── Dockerfile            # Docker build file
```

---

## 🚀 Features

- Returns current UTC timestamp
- Detects and returns visitor’s IP address
- Runs in a Docker container
- Production-ready with Gunicorn

---

## 🧾 API Endpoint

### `GET /`

Returns:

```json
{
  "timestamp": "2025-04-16T15:20:30.123456+00:00",
  "ip": "127.0.0.1"
}
```

---

## 🐍 Python Dependencies

```text
Flask==2.3.3
pytz==2024.1
gunicorn==21.2.0
Jinja2==3.1.2
```

---

## 🔧 Gunicorn Configuration

File: `gunicorn-config.py`

```python
bind = "0.0.0.0:80"
workers = 2
timeout = 30
```

---

## 🧨 Shell Script to Start App

File: `start.sh`

```bash
#!/bin/bash
set -e
echo "Starting Gunicorn on port 80..."
exec gunicorn -c gunicorn-config.py app:app
```


---

## 🐳 Dockerfile

```Dockerfile
FROM public.ecr.aws/docker/library/python:3.11

# Set working directory inside the container
WORKDIR /app

# Copy only the app folder content into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the start script is executable
RUN chmod +x start.sh

# Expose port 80 for the container
EXPOSE 80

# Start the app using the start script
CMD ["./start.sh"]
```


---

## ⚙️ Setup Instructions

### 🐳 Docker Build

To build the Docker image, run:

```bash
docker build -t SimpleTimeService .
```

### ▶️ Run the Container

```bash
docker run -p 80:80 SimpleTimeService
```

> ✅ Your app will now be available at [http://localhost](http://localhost)



---

## ✅ Testing the App

Use a browser or `curl`:

```bash
curl http://localhost
```

Expected response:

```json
{
  "timestamp": "2025-04-16T15:20:30.123456+00:00",
  "ip": "127.0.0.1"
}
```


---

## 🧹 Stopping & Cleaning Up

```bash
docker ps                   # Get container ID
docker stop <container_id>
docker rm <container_id>
```
---



---

## 📌 Notes

- The application is designed for demonstration or internal use.
- Use proper security, logging, and monitoring for production deployments.


## 📄 License

VIJAYARAMARAO SIRIGIRI

vijay49m@gmail.com

+91-6301773727