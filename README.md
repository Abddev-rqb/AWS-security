# AWS Organization Security Platform

## Overview

This repository simulates a production-grade AWS security governance model for a multi-account environment.  

The focus is not feature completeness, but risk reduction, blast-radius containment, and identity-first security controls suitable for enterprise and fintech environments.

This project models how a security engineering team operates in production: guardrails first, workloads second.

---

## Design Principles

- Identity compromise is treated as the primary breach vector.
- Organization-level controls must be non-bypassable.
- Logging must be immutable and outside workload blast radius.
- Automation is powerful but constrained.
- Incidents must feed back into preventive controls.

---

## Architecture Summary

### 1. Organization Governance
- AWS Organizations with Security, Logging, and Workload OUs
- SCP-based invariants at the root level
- Guardrails enforced before workload deployment

### 2. Identity & Access Management
- No IAM users for human access
- Role-based access model
- Mandatory permission boundaries
- Separation between human and automation roles

### 3. Preventive Controls
- SCPs block:
  - Organization escape
  - CloudTrail tampering
  - Root misuse
  - Identity privilege escalation patterns

### 4. Centralized Logging
- Organization-wide CloudTrail
- Dedicated Log Archive account
- Log file validation enabled
- S3 versioning and immutability model
- Workload accounts cannot delete audit logs

### 5. Incident Response
- Structured runbook for compromised identity
- Containment-first methodology
- Persistence hunting
- Data-plane impact analysis
- Control reinforcement loop

---

## Threat Model Focus

This platform assumes:

- Credentials will leak.
- IAM misconfiguration will occur under delivery pressure.
- Attackers will attempt privilege escalation and persistence.
- Audit visibility must survive account compromise.

---

## What Is Intentionally Out of Scope

- Network topology deep-dive (VPC engineering)
- Full SIEM implementation
- Control Tower automation specifics
- Third-party security tooling integration
- Inspector / Macie deep tuning

These can integrate on top of this governance foundation.

---

## What this Project Achieves ?

This project demonstrates capability in:

- Architecting multi-account security frameworks
- Designing SCP-first governance models
- Implementing permission boundaries for delegated IAM
- Modeling blast radius under compromise
- Conducting structured incident response
- Preserving audit integrity

---

## Operating Philosophy

Security defines the envelope.  
Engineering operates freely within it.  
Guardrails are enforced in code, not policy documents.

---

## Author

Execution-first AWS Security Engineer  
Focused on identity governance, blast-radius control, and production trust.


