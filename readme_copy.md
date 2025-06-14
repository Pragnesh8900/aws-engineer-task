# 🛠️ Founding AWS Engineer – Practical Task

Welcome! This task is your first step toward joining **EagerMinds** as a **Founding AWS Engineer**. We’re looking for someone who can build real infrastructure—not just talk about it.

This task mimics what you’ll do at the job: automate deployments, architect securely, and think with a product-first mindset.

---

## 📦 Task Overview

**Goal:** Deploy a containerized sample app (Node.js, Next.js, or any static site) on AWS using **Terraform** (or CDK) and follow security, scalability, and automation best practices.

---

## ✅ Deliverables

- A working Terraform (or CDK) project to deploy the architecture
- Code pushed to your **forked repo**
- A `README.md` explaining your design decisions and how to deploy

---

## 📋 Task Details

### 1. Infrastructure Requirements

- **VPC**
  - Public and private subnets across 2 AZs
  - NAT Gateway for outbound internet

- **Compute**
  - Use **ECS Fargate** (or EC2) to deploy a sample app container
  - Attach an **Application Load Balancer** (ALB) in front
  
- **Storage**
  - Use **S3** for static assets or logs

- **Networking & Security**
  - Secure **Security Groups** (no open 0.0.0.0 unnecessarily)
  - Use **ACM + HTTPS** on ALB
  - Use **IAM roles** for ECS task

- **CI/CD (Bonus)**
  - Set up GitHub Actions or CodePipeline to deploy automatically on commit

- **Monitoring**
  - Enable basic **CloudWatch** logging for ECS tasks and ALB access logs

---

## 🧪 Evaluation Criteria

| Criteria                         | Points |
|----------------------------------|--------|
| IaC Code Quality & Modularity    | 20     |
| AWS Services Used Correctly      | 20     |
| Security Best Practices          | 20     |
| Documentation (README)          | 15     |
| Bonus: CI/CD or Monitoring       | 10     |
| Working Architecture             | 15     |

> 🔥 Bonus: Small touches like cost efficiency, tagging, Graviton instances, etc.

---

## 📤 How to Submit

1. **Fork this repository** to your own GitHub.
2. Push your code + README to the fork.
3. Submit your repo link to us via the form/email shared.

---

## 🧠 Tips

- You may use ChatGPT, Google, or any docs. Just don’t blindly copy code.
- Use Terraform modules or CDK constructs wisely. Clean code > fancy features.

---

## 💬 Questions?
Raise a GitHub issue or email us at [admin@eagerminds.in](mailto:admin@eagerminds.in).

We’re excited to see what you build 🚀
