# Terraform & Java CI/CD Pipeline Project

This repository contains my **DevOps CI/CD pipeline project** for a Java application.  
I built this project by learning from various resources and implementing the pipeline myself. It covers **infrastructure provisioning, automated builds, deployments using Jenkins, Docker, Ansible, and Kubernetes**, all managed with Terraform.

---

## Project Overview

The goal of this project was to create a **fully automated CI/CD pipeline** for a Java application.  
The pipeline includes:

- Provisioning servers and resources with **Terraform**  
- Setting up a **Jenkins CI/CD pipeline**  
- Building a **Java application using Maven**  
- Deploying artifacts to **Tomcat servers**  
- Containerizing applications with **Docker**  
- Automating deployments with **Ansible**  
- Managing deployments and scaling with **Kubernetes (EKS)**  

---

## Features Implemented

- **Infrastructure as Code** using Terraform
  - Automated setup of servers and required resources
- **Continuous Integration & Delivery** using Jenkins
  - Build Java applications automatically
  - Pull code from GitHub and run CI/CD pipelines
- **Docker Integration**
  - Create Docker images and containers for deployment
  - Automate deployment using Jenkins jobs
- **Ansible Automation**
  - Automate container creation and deployment
  - Integrate Ansible with Jenkins for CI/CD
- **Kubernetes Deployment**
  - Deploy Docker containers on Kubernetes
  - Use Ansible to apply deployment and service manifests
  - Enable rolling updates to keep deployments up-to-date

---

## Repo Structure

```
devops-project-1/
├── terraform/        # Terraform scripts for provisioning infrastructure
├── docker/           # Dockerfiles for Tomcat and application containers
├── ansible/          # Ansible playbooks for deployment automation
├── jenkins/          # Jenkins pipeline scripts or job configurations
├── k8s/              # Kubernetes manifests for deployment and services
├── README.md         # This file
├── .gitignore        # Ignored files like .terraform/, *.tfstate, *.tfvars
```

---

## Important Notes

- **Sensitive files** like `*.tfvars` and Terraform state files are **ignored** via `.gitignore`.  
- All `.terraform/` folders (local modules, caches) are ignored to keep the repo clean.  
- The project was implemented **from scratch** based on learning and experimentation — not copied.  

---

## Tools & Technologies Used

- **Terraform** – Infrastructure as Code  
- **Jenkins** – CI/CD server  
- **Maven** – Java build tool  
- **Docker** – Containerization  
- **Ansible** – Deployment automation  
- **Kubernetes (EKS)** – Container orchestration  
- **Git & GitHub** – Version control  

---

## How to Use

1. Clone the repository:
```bash
git clone https://github.com/janindujm/Terraform-code-to-Java-CICD.git
```

2. Initialize Terraform:
```bash
cd terraform
terraform init
```

3. Apply infrastructure:
```bash
terraform apply
```

4. Follow Jenkins, Docker, and Ansible instructions in their respective folders to set up the CI/CD pipeline.  

---

## Learning Outcomes

By building this project, I gained hands-on experience in:

- Designing **end-to-end CI/CD pipelines**  
- Automating deployments for Java applications  
- Using **Terraform** for infrastructure provisioning  
- Integrating **Jenkins with Docker and Ansible**  
- Deploying applications on **Kubernetes clusters**  
- Writing reusable **Terraform, Docker, and Ansible scripts**  

---

*This repository reflects my own work and learning process, combining Terraform, Jenkins, Docker, Ansible, and Kubernetes to create a functional CI/CD pipeline.*

