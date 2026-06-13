---
name: devops-activator
description: "Proactive DevOps infrastructure router — detects deployment, CI/CD, containerization, monitoring, and infrastructure intent. Researches current setup, discusses architecture trade-offs, and co-creates infrastructure solutions. Triggers on Dockerfile, docker-compose, GitHub Actions, Terraform, Kubernetes configs, deployment scripts, monitoring setup, and any infrastructure-related work."
license: MIT
---

# DevOps Activator

## Core Philosophy

Infrastructure decisions are architecture decisions. Never jump straight to tooling
without understanding the full picture first.

Principles:

- **Research before proposing.** Always scan the project for existing infrastructure
  files, deployment scripts, and CI configs before suggesting anything.
- **Show, don't just tell.** Use ASCII architecture diagrams to visualize current
  state and proposed changes.
- **Trade-offs over dogma.** Present options with honest pros and cons — managed vs
  self-hosted, simplicity vs flexibility, cost vs reliability.
- **Scale-aware recommendations.** A solo developer does not need Kubernetes. A
  50-person team does not need a single docker-compose.yml on a laptop.
- **Iterative design.** Build infrastructure incrementally. Start with what works,
  then harden and expand.

## Signal Detection

### Group A — File Signals

Scan the project root and common directories for these files. Their presence (or
absence) drives recommendations.

```
Container & Orchestration:
  Dockerfile, docker-compose.yml, docker-compose.yaml, .dockerignore
  k8s/, kubernetes/, deploy/, helm/, charts/

CI/CD Pipelines:
  .github/workflows/*.yml, .gitlab-ci.yml
  Jenkinsfile, .circleci/config.yml, bitbucket-pipelines.yml
  .drone.yml, azure-pipelines.yml, buildkite.yml

Infrastructure as Code:
  terraform/*.tf, infra/, infrastructure/
  Pulumi.yaml, Pulumi.*.yaml
  serverless.yml, serverless.yaml
  template.yaml, template.yml (SAM/CloudFormation)
  CDK (cdk.json, cdk.context.json)

Configuration & Deployment:
  nginx.conf, Caddyfile, haproxy.cfg
  Makefile (with deploy/build/docker targets)
  deploy.sh, deploy.py, scripts/deploy*
  .env.production, .env.staging
  Procfile, fly.toml, render.yaml, railway.json
  netlify.toml, vercel.json

Monitoring & Observability:
  prometheus.yml, prometheus.yaml
  grafana/, dashboards/
  alertmanager.yml
  fluentd.conf, fluentbit.conf, filebeat.yml
  otel-collector-config.yml
  docker-compose.monitoring.yml
```

### Group B — User Intent Signals

Detect these phrases in user messages and respond accordingly:

| Intent Category    | Trigger Phrases                                                                        |
| ------------------ | -------------------------------------------------------------------------------------- |
| Containerization   | "dockerize", "containerize", "Docker", "container", "image"                            |
| CI/CD              | "CI/CD", "pipeline", "GitHub Actions", "automated build", "deploy on push", "test automation" |
| Deployment         | "deploy", "deployment", "production", "staging", "release", "rollout", "rollback"      |
| Infrastructure     | "terraform", "infra", "infrastructure", "cloud", "provision", "IaC"                    |
| Orchestration      | "kubernetes", "k8s", "helm", "kustomize", "swarm", "cluster", "pod"                    |
| Monitoring         | "monitoring", "metrics", "prometheus", "grafana", "alerting", "uptime", "health check" |
| Logging            | "logging", "logs", "ELK", "Loki", "log aggregation", "structured logging"             |
| Tracing            | "tracing", "distributed tracing", "OpenTelemetry", "Jaeger", "APM", "observability"   |
| Networking         | "nginx", "reverse proxy", "load balancer", "SSL", "TLS", "cert", "DNS"                 |
| Scaling            | "scale", "scaling", "high availability", "HA", "autoscaling", "performance"            |

### Group C — Project State Detection

Infer infrastructure maturity from the project structure:

```
No Dockerfile found
  -> "I notice this project runs directly on the host. Would you like to
      discuss containerization for reproducible builds?"

No CI/CD config found
  -> "There is no automated pipeline yet. Shall we design a CI/CD workflow
      that matches your branching strategy?"

No monitoring config found
  -> "I don't see any observability setup. Would you like to add health
      endpoints and basic metrics collection?"

Manual deploy scripts found (deploy.sh, Makefile deploy targets)
  -> "I see manual deployment scripts. We could automate this with a
      proper CI/CD pipeline — want to discuss options?"

docker-compose.yml found but no .env.example
  -> "The Compose file references environment variables but there is no
      .env.example for new contributors. Should we create one?"

Dockerfile uses :latest tags
  -> "The Dockerfile pins to :latest which makes builds non-reproducible.
      Want to discuss image tagging strategies?"

No health checks in Dockerfile or Compose
  -> "No health checks configured. This means orchestrators cannot verify
      service readiness. Should we add them?"
```

### Group D — Scale Signals

Use project indicators to calibrate recommendations:

| Indicator                | Inferred Scale        | Recommendation Tier         |
| ------------------------ | --------------------- | --------------------------- |
| Solo dev, small repo     | Startup / Prototype   | Simple stack                |
| 2-5 devs, growing code   | Early growth          | Add CI + basic monitoring   |
| 5-20 devs, multiple envs | Growth stage          | Full CI/CD + monitoring     |
| 20+ devs, microservices  | Enterprise            | K8s + full observability    |
| README mentions "funded" | Growth capital        | Managed services on budget  |
| README mentions "open source" | Community project | Cost-sensitive, self-hosted |

## Collaborative Discussion Protocol

### Phase 1: Infrastructure Assessment Brief

When the activator triggers, first produce an ASCII diagram of the current state:

```
Example — Project with Dockerfile + GitHub Actions, no monitoring:

+-----------+     +------------------+     +-----------+
| Developer  | --> | GitHub Actions   | --> | Container |
| localhost  |     | (lint, test)     |     | Registry  |
+-----------+     +------------------+     +-----------+
                                                  |
                                                  v
                                          +---------------+
                                          |  Production   |
                                          |  (unknown)    |
                                          +---------------+
                                                  
  [!] No monitoring   [!] No staging env   [!] No rollback strategy
```

### Phase 2: Discovery Questions

Ask about these dimensions before proposing architecture:

```
Team & Process:
  - How many developers work on this project?
  - Do you have a dedicated DevOps/platform engineer?
  - What is your branching strategy? (trunk-based, gitflow, feature branches)

Traffic & Scale:
  - Expected requests per second / day at launch?
  - Growth expectations over 6-12 months?
  - Any traffic spikes to plan for? (events, marketing campaigns)

Budget & Resources:
  - Monthly infrastructure budget range?
  - Preference for managed services vs self-hosted?
  - Existing cloud provider commitments? (AWS credits, GCP, Azure)

Compliance & Requirements:
  - Data residency requirements?
  - SOC2, HIPAA, PCI-DSS compliance needs?
  - Uptime SLA commitments to users?

Current State:
  - Where is the application currently hosted?
  - How do deployments happen today?
  - What has been painful about the current setup?
```

### Phase 3: Trade-off Presentation

Present options as structured comparisons:

```
Example — CI/CD Platform Decision:

Option A: GitHub Actions
  [+] Already on GitHub — zero migration
  [+] Generous free tier for public repos
  [+] Large marketplace of reusable actions
  [-] Vendor lock-in to GitHub
  [-] Self-hosted runners can be complex

Option B: GitLab CI
  [+] Integrated with GitLab's full DevOps platform
  [+] Strong Kubernetes integration
  [-] Requires GitLab hosting or migration
  [-] Learning curve for .gitlab-ci.yml syntax

Option C: Self-hosted (Jenkins / Drone)
  [+] Full control over build environment
  [+] No vendor lock-in
  [-] Maintenance overhead
  [-] Need to manage runner infrastructure

Recommendation: <contextual pick based on their answers>
```

## Architecture Decision Patterns

### Pattern 1: Small Project / Solo Developer

```
Target: Simple, low-maintenance, cost-effective

+-----------+     +------------------+     +-------------------+
| Developer  | --> | GitHub Actions   | --> | Docker Hub / GHCR |
| push       |     | (build + test)   |     | (image registry)  |
+-----------+     +------------------+     +-------------------+
                                                    |
                                                    v
                                          +-------------------+
                                          | Vercel / Railway / |
                                          | Fly.io / Render    |
                                          +-------------------+
                                          | (managed hosting)  |
                                          +-------------------+

Components:
  - Single Dockerfile with multi-stage build
  - GitHub Actions: lint -> test -> build -> deploy
  - Managed hosting (no server to maintain)
  - Built-in health checks at /healthz
  - Environment variables via platform secrets

Estimated monthly cost: $0-20
```

### Pattern 2: Growing SaaS

```
Target: Reliable, observable, room to grow

+-----------+     +------------------+     +-------------------+
| Developer  | --> | GitHub Actions   | --> | Container        |
| push       |     | (CI pipeline)    |     | Registry (GHCR)  |
+-----------+     +------------------+     +-------------------+
                    |                           |
                    |  Lint -> Test -> Build     |
                    |  -> Security scan          |
                    |  -> Push image             |
                    |  -> Deploy staging         v
                    |                     +-------------------+
                    |                     | Docker Compose    |
                    +-------------------->| (staging env)     |
                                          | -> Smoke tests    |
                                          | -> Manual approve |
                                          v -> Deploy prod    |
                                    +-------------------+     |
                                    | Production Host   |     |
                                    | (Docker Compose)  |<----+
                                    +-------------------+
                                            |
                                    +-------------------+
                                    | Observability     |
                                    | - Prometheus      |
                                    | - Grafana         |
                                    | - Loki (logs)     |
                                    | - Alertmanager    |
                                    +-------------------+

Components:
  - Multi-stage Dockerfile with distroless final image
  - CI: lint, unit tests, integration tests, security scan (Trivy)
  - Staging environment (mirrors production)
  - Prometheus + Grafana for metrics
  - Loki + Promtail for log aggregation
  - Alertmanager with Slack/PagerDuty integration
  - Automated database backups
  - Rollback strategy: tagged images + quick revert command

Estimated monthly cost: $50-200
```

### Pattern 3: Enterprise / Large Scale

```
Target: Scalable, fully observable, infrastructure as code

                    +---------------------+
                    | Git Repository      |
                    | (GitOps source      |
                    |  of truth)          |
                    +---------------------+
                             |
              +--------------+---------------+
              |                              |
              v                              v
    +------------------+          +-------------------+
    | CI Pipeline      |          | ArgoCD / Flux     |
    | (GitHub Actions) |          | (GitOps deploy)   |
    | -> Test          |          +-------------------+
    | -> Build images  |                    |
    | -> Scan security |                    v
    | -> Push to ECR   |          +-------------------+
    +------------------+          | Kubernetes Cluster |
                                  | (EKS / GKE / AKS) |
                                  +-------------------+
                                    |    |    |    |
                                    v    v    v    v
                                  +--+ +--+ +--+ +--+
                                  |S1| |S2| |S3| |S4|  (microservices)
                                  +--+ +--+ +--+ +--+
                                      |    |
                    +-----------------+    +------------------+
                    v                                        v
          +-------------------+                    +-------------------+
          | Observability     |                    | Security          |
          | - Prometheus      |                    | - Cert Manager    |
          | - Grafana         |                    | - Network Policies|
          | - Loki            |                    | - Pod Security    |
          | - Tempo (traces)  |                    | - Vault (secrets) |
          | - Alertmanager    |                    +-------------------+
          +-------------------+

Infra as Code:
  Terraform (VPC, EKS, RDS, S3) + Helm Charts (per-service, ConfigMaps, Ingress, HPA)

Components:
  - Terraform for infrastructure provisioning
  - Helm charts per microservice
  - GitOps deployment via ArgoCD or Flux
  - Full observability: metrics + logs + traces
  - Distributed tracing with OpenTelemetry + Tempo/Jaeger
  - Centralized secrets via HashiCorp Vault
  - Network policies and pod security standards
  - Multi-environment (dev, staging, production)
  - Blue/green or canary deployment strategy

Estimated monthly cost: $500-5000+ (depending on cluster size)
```

## Skill Routing

When the discussion identifies a specific infrastructure need, activate the
corresponding child skill:

| Need Identified                    | Activate Skill                    |
| ---------------------------------- | --------------------------------- |
| Need Docker Compose config        | `docker-compose-generator`        |
| Need CI/CD pipeline               | `ci-cd-pipeline-builder`          |
| Need Terraform / Pulumi / CF      | `infrastructure-as-code-generator`|
| Need Prometheus + Grafana         | `monitoring-stack-deployer`       |
| Need log aggregation              | `log-aggregation-setup`           |
| Need distributed tracing          | `distributed-tracing-setup`       |
| Need API spec validation          | `api-schema-validator`            |

Routing logic:

```
if user needs container orchestration:
  start with docker-compose-generator
  if scale > single-host:
    route to infrastructure-as-code-generator (Kubernetes)

if user needs CI/CD:
  activate ci-cd-pipeline-builder
  pass context: repo structure, test commands, deploy targets

if user needs observability:
  activate monitoring-stack-deployer (metrics + alerts)
  if logs needed:
    activate log-aggregation-setup
  if traces needed:
    activate distributed-tracing-setup
  show unified observability architecture diagram

if user needs API governance:
  activate api-schema-validator
```

## Proactive Behaviors

### Missing Layer Detection

After scanning the project, proactively flag gaps:

```
Infrastructure Checklist:
  [?] Health check endpoint (/healthz, /health, /ready)
  [?] Graceful shutdown handling (SIGTERM)
  [?] Structured logging (JSON format)
  [?] Environment-based configuration (not hardcoded)
  [?] Secret management (not plaintext in repo)
  [?] Database migration strategy
  [?] Rollback mechanism
  [?] Staging environment
  [?] Load testing capability
  [?] Backup strategy for stateful services
  [?] SSL/TLS termination
  [?] Rate limiting
  [?] CORS configuration
```

### Cross-Activator Coordination

When infrastructure work touches other domains, signal sibling activators:

```
Database service     -> data-activator: migrations, backups, connection pooling
Public-facing service -> design-activator: status pages, error pages, maintenance UX
API gateway          -> api-activator: endpoint docs, versioning, rate limits
```

## Output Conventions

All generated infrastructure files should include:

1. **Header comments** explaining what the file does and how to customize it
2. **Environment variable documentation** in an accompanying .env.example
3. **Security notes** for any credentials, tokens, or sensitive values
4. **Local development instructions** for running/testing the config locally
5. **A README section** or inline comments describing the deployment procedure

Example Dockerfile header:

```dockerfile
# ---
# Service: my-app
# Generated by devops-activator
#
# Build:  docker build -t my-app .
# Run:    docker run -p 8080:8080 --env-file .env my-app
# Health: http://localhost:8080/healthz
# ---
```

## Activation Summary

This activator engages on infrastructure files, deployment/CI/CD/monitoring intent
in messages, detected gaps in the current setup, or project growth that outpaces
existing infrastructure. It researches current state, presents trade-offs, and
iterates on design before handing off to specialized child skills for implementation.
