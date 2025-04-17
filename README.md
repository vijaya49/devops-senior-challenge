# 🕒 Task 1: Simple Time Service

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
- We can Use proper security, logging, and monitoring for production deployments.



---
# 🚀 Task 2: ECS Fargate Terraform Module 

This Terraform module (`ecs-fargate`) provisions a complete containerized application infrastructure on **AWS ECS with Fargate**, along with related resources like VPC, ALB, ACM, Route 53, IAM roles, and more.

---

## 📁 Project Structure

```
ecs-fargate/
├── acm.tf           # SSL/TLS certificate via ACM
├── ecr.tf           # ECR repository to store Docker images
├── ecs.tf           # ECS cluster, task definitions, and services (Fargate)
├── elb.tf           # Application Load Balancer (ALB)
├── iam.tf           # IAM roles and policies
├── outputs.tf       # Module outputs
├── route53.tf       # DNS records in Route53
├── sg.tf            # Security groups
├── variables.tf     # Module input variables
├── vpc.tf           # VPC, subnets, route tables, etc.
├── simple-time-service/ # Application-specific files (if any)
```

Root:
```
main.tf             # Consumes the ecs-fargate module
variables.tf        # Variables passed to the module
versions.tf         # Required provider versions
README.md           # You're here!
```

---

## 🧩 What This Module Does

This module will:

- Create a **VPC** with public/private subnets across AZs
- Provision an **ECR** repository for your Docker image
- Set up an **ECS Cluster** with **Fargate** tasks
- Deploy your container using **ECS service**
- Attach a **Load Balancer** to route traffic
- Manage **IAM roles** for ECS execution
- Configure **SSL certificates** using ACM
- Set up **DNS** in Route53
- Secure everything using **Security Groups**

---

## 📦 How to Use

Here’s how to call the module in your root `main.tf`:

```hcl
module "ecs_fargate" {
  source              = "./ecs-fargate"
  app_name            = "SimpTimeServ-new"
  region              = "us-east-1"
  domain_name         = "simpletimeservice.cloudvj.in"
  hosted_zone_id      = "Z03659932DLDYYQJTHLW"
  container_port      = 80
  image_tag           = var.image_tag
}
```

📝 Make sure your `variables.tf` contains the required `image_tag` variable.

---

## ✅ Prerequisites

- Terraform CLI installed
- AWS credentials configured (`~/.aws/credentials` or via env variables)
- A hosted zone already set up in **Route 53**
- An image pushed to **ECR** with the tag passed in `image_tag`

---

## 🛠️ How to Deploy

```bash
terraform init
terraform plan
terraform apply
```

---

## 📤 Outputs

After successful deployment, the module can output useful info such as:

- Load balancer DNS
- ECS service name
- VPC ID
- Subnet IDs

---

## 🧹 Cleanup

To tear down the infrastructure:

```bash
terraform destroy
```

---

## 📎 Notes

- This setup uses **Fargate launch type**, so you don’t need to manage EC2 instances.
- The SSL certificate is validated via **DNS using Route 53**, so ensure your domain is in the correct hosted zone.

---

## 👨‍💻 Maintainers

This module was crafted for internal DevOps projects but is reusable for any ECS-Fargate based deployment for production grade we can add more features on this module like autoscaling etc, and we can customize it for our app needs.

---


# CI-CD: Simple Time Service on AWS ECS Fargate with Terraform

This repository contains a sample microservice called `simple-time-service` deployed on AWS ECS Fargate using Infrastructure as Code (IaC) with Terraform. CI/CD pipelines are managed using GitHub Actions.

## 🧭 Overview

This project demonstrates:

- Dockerizing a simple application (`simple-time-service`)
- Deploying it to AWS ECS Fargate
- Managing infrastructure with Terraform
- CI/CD using GitHub Actions

## 📁 Folder Structure

```
.
├── .github/workflows       # GitHub Actions workflows
│   ├── deploy.yml          # Triggers on app source code changes
│   └── terraform.yml       # Triggers on infrastructure code changes
├── ecs-fargate             
├── simple-time-service     
├── main.tf                 
├── variables.tf            
├── versions.tf             
├── README.md               
```

---

## 🚀 Workflows

### 1. **Application Deployment Workflow (`deploy.yml`)**

**Trigger:**  
Runs automatically on changes to files inside the `simple-time-service` directory.

**What it does:**

- Builds a Docker image for the service
- Tags and pushes the image to Amazon ECR
- Initializes and validates Terraform
- Applies Terraform configuration with the updated image tag to ECS

**Image Tag Format:**  
A short SHA-based image tag prefixed with `ecs-`, e.g. `ecs-abc12`.

### 2. **Infrastructure Deployment Workflow (`terraform.yml`)**

**Trigger:**

- Runs automatically when any `.tf` file is changed or committed
- Can also be triggered manually via the **workflow dispatch** feature in GitHub

**What it does:**

- Initializes Terraform
- Formats and validates the code
- Plans and applies infrastructure changes

---

## 🔧 How to Use

### Prerequisites

- AWS account with necessary IAM permissions
- GitHub secrets configured:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- Amazon ECR repository created (default: `simptimeserv-new`)

### Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

2. **Set up secrets in GitHub**

Navigate to **Settings > Secrets and variables > Actions** and add:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

3. **Push changes**

- Push code changes to the `simple-time-service` directory to trigger the **application deployment workflow**.
- Push any `.tf` file changes to trigger the **infrastructure workflow**.

---

## 🧱 Terraform Variables

The following variables are used in Terraform (`variables.tf`):

- `image_tag` – Docker image tag deployed to ECS

These are passed dynamically during the `deploy.yml` workflow using:

```bash
terraform apply -var="image_tag=$IMAGE_TAG"
```

---

## 📦 Technologies Used

- **AWS ECS Fargate**
- **Amazon ECR**
- **Terraform**
- **GitHub Actions**
- **Docker**

---

## ✅ Good to Know

- The ECS service is updated only if there's a change in the Docker image (via GitHub Actions).
- Manual workflow dispatch is available for infrastructure updates (`terraform.yml`).
- The Docker image is built from the source in `simple-time-service/`.

---

## ✅ Imporovements we can do

- Due to time constraints, I developed this module with only the minimum required features. If I get sufficient time on this project, I would be happy to enhance it further with more features and make it more robust and reliable.
- Currently, the application is running as the root user. I have tested it locally with a non-root user and it worked well. However, I'm encountering some issues while deploying it on ECS Fargate with a non-root user, which I need to explore and troubleshoot further.

---


## 🧑‍💻 Contributors

- VIJAYARAMA RAO SIRIGIRI
- vijay49m@gmail.com
- +91-6301773727

---

