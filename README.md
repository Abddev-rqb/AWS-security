# AWS Organization & IAM Governance (Terraform)

## Overview

Production‑grade AWS Organizations and IAM governance implemented using Terraform. This repository demonstrates **multi‑account governance**, **Service Control Policies (SCPs)**, and **secure cross‑account IAM role access** — patterns commonly used in product‑based, FinTech, and regulated enterprise environments.

## What This Project Demonstrates

* Centralized AWS Organizations management
* SCP‑based preventive security controls
* Environment‑level isolation (dev, sandbox)
* Secure IAM cross‑account role assumption
* Modular, reusable Terraform design

## Repository Structure (High Level)

```
org-management/
├── envs/
│   ├── dev/           # Dev governance setup
│   ├── sandbox/       # Org‑level SCP enforcement
│   ├── sandbox-1/iam/ # Source account (assumes role)
│   └── sandbox-2/iam/ # Destination account (trusted role)
│
├── modules/
│   ├── organizations/ # AWS Organizations abstraction
│   └── scp/           # Service Control Policy module
```

## Key Security Use Cases

* **SCP Enforcement:** Restricts AWS service actions at the account / OU level (e.g., region‑based S3 restrictions)
* **Cross‑Account IAM:** Enables least‑privilege access between isolated AWS accounts without sharing credentials
* **Blast Radius Control:** Each environment and account maintains independent Terraform state

## Design Principles

* Security by default
* Least privilege IAM
* Clear separation of concerns (envs vs modules)
* Enterprise‑aligned folder structure

## Real‑World Relevance

This setup mirrors how **large product companies, banks, and FinTech platforms** manage AWS at scale — with centralized governance, strict access boundaries, and auditable infrastructure as code.

> Note: Local Terraform state is used for demonstration. In production, this would be backed by an S3 remote backend with DynamoDB state locking.

---

**Author:** Abdul Raqeeb
**Focus Areas:** AWS Organizations, IAM, Cloud Security, Terraform
