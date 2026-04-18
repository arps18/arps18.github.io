---
title: "Kubernetes for Microservices: Lessons Learned"
date: 2026-01-20T09:00:00-05:00
draft: false
tags: ["kubernetes", "docker", "microservices", "devops"]
categories: ["engineering"]
summary: "A year of running microservices on Kubernetes — what worked, what didn't, and what I'd do differently."
ShowToc: true
TocOpen: false
---

After a year of orchestrating microservices on Kubernetes in production, I've collected a set of lessons — some earned painfully. Here they are.

## 1. Resource limits are not optional

Early on, we ran pods without CPU and memory limits. It "worked" — until one noisy neighbor ate an entire node's resources and took down the services around it.

Now every pod has explicit requests and limits:

```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

**Requests** guarantee the scheduler places your pod somewhere with capacity. **Limits** cap bad behavior. Both are worth the five minutes it takes to set them.

## 2. Readiness probes matter more than liveness probes

A **liveness probe** tells Kubernetes when to restart a pod. A **readiness probe** tells it when to start sending traffic. People often conflate these.

If your readiness probe is missing or wrong, you'll route requests to pods that aren't actually ready to serve them — and see mysterious 502s during deployments.

```yaml
readinessProbe:
  httpGet:
    path: /health/ready
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
```

Expose `/health/ready` that checks DB connections, cache warmup, etc. — not just "am I alive."

## 3. ConfigMaps and Secrets — separate them

Configuration values go in ConfigMaps. Anything sensitive — API keys, DB credentials, tokens — goes in Secrets. Don't bake either into images.

And enable encryption at rest for etcd. Kubernetes Secrets are base64-encoded by default, not encrypted.

## 4. Horizontal Pod Autoscaling is worth the setup

HPA scales pods based on metrics. It's a small config file and it's saved us during unexpected traffic spikes:

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

## 5. Invest in observability early

Prometheus, Grafana, centralized logging — set these up before you need them. When something breaks at 2 AM, you'll want the data already flowing.

---

Kubernetes has a steep learning curve, but the operational leverage once you're past it is real. Start small, get the basics right, and the rest follows.
