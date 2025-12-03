# AWS ECS Zero-Downtime Deployment Pipeline (Blue/Green)

![Build Status](https://img.shields.io/badge/build-passing-brightgreen) ![AWS](https://img.shields.io/badge/AWS-ECS%20%7C%20Fargate-orange) ![Docker](https://img.shields.io/badge/Docker-Containerized-blue)

## 📋 Project Overview
This repository demonstrates a production-grade CI/CD pipeline designed for **High Availability** and **Zero Downtime**.

It deploys a containerized Node.js application to **AWS ECS (Fargate)** using a **Blue/Green deployment strategy**. This ensures that new versions of the application are fully tested and healthy before traffic is shifted, eliminating the risk of deploying broken code to users.

## 🏗 Architecture & Tech Stack
* **Source Control:** GitHub
* **CI/CD Orchestration:** GitHub Actions
* **Container Registry:** AWS ECR (Elastic Container Registry)
* **Compute:** AWS ECS Fargate (Serverless Containers)
* **Deployment Strategy:** AWS CodeDeploy (Blue/Green with traffic shifting)
* **Load Balancing:** Application Load Balancer (ALB)

## 🚀 Key Features
1.  **Automated Pipeline:** Every push to `main` triggers a build, security scan, and deployment.
2.  **Zero Downtime:** Uses CodeDeploy to spin up a replacement task set (Green). Traffic is only rerouted from the old set (Blue) after health checks pass.
3.  **Rollback Capability:** If the new version fails health checks, the deployment automatically rolls back.
4.  **Security:** IAM Roles follow the principle of least privilege; Docker images are scanned for vulnerabilities.

## 🛠️ How it Works
1.  **Push:** Developer pushes code to GitHub.
2.  **Build:** GitHub Actions builds the Docker image.
3.  **Push:** Image is tagged with the SHA and pushed to AWS ECR.
4.  **Deploy:** A new revision of the ECS Task Definition is created.
5.  **Shift:** AWS CodeDeploy triggers. It spins up new tasks, waits for health checks, and shifts traffic on the Load Balancer listener.

## 📂 Project Structure
* `app/`: The Node.js source code and Dockerfile.
* `.github/workflows`: The YAML configuration for the CI/CD pipeline.
* `infrastructure/`: JSON templates for ECS Task Definitions.

---
*Muhammad Zaffar Saffee - DevOps & Cloud Security Engineer*


## License
* This repository contains original work, written independently.
* You may modify and extend freely.
