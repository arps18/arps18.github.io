---
title: "Optimizing Oracle SQL: From 8 Seconds to 500ms"
date: 2026-03-15T10:00:00-05:00
draft: false
tags: ["sql", "oracle", "performance", "backend"]
categories: ["engineering"]
summary: "How I took a critical query from 8 seconds down to 500ms — a 16× speedup — through indexing, execution plan analysis, and a few hard-earned lessons."
ShowToc: true
TocOpen: false
---

One of the most satisfying wins I had recently at work was taking an Oracle SQL query that was running in 8 seconds and getting it down to 500ms. That's a 16× speedup, and it happened in an afternoon. Here's the story.

## The problem

The query was part of a data processing pipeline running in production. Users were seeing noticeable delays, and the query was being called frequently enough that it was spiking database CPU during peak hours.

The original query looked something like this (simplified):

```sql
SELECT t1.id, t1.name, t2.status, t3.amount
FROM transactions t1
JOIN accounts t2 ON t1.account_id = t2.id
JOIN payments t3 ON t3.transaction_id = t1.id
WHERE t1.created_date >= SYSDATE - 30
  AND t2.region = 'US'
ORDER BY t1.created_date DESC;
```

Nothing unusual — but it was scanning millions of rows on every execution.

## Step 1: Read the execution plan

The first thing I did was pull the execution plan with `EXPLAIN PLAN`. The output showed a **full table scan** on `transactions`, which has tens of millions of rows. That's your signal: the optimizer isn't using an index.

## Step 2: Add the right index

The query filters on `created_date` and joins on `account_id`. A composite index on `(created_date, account_id)` lets the optimizer narrow the date range first, then the join happens on a much smaller set.

```sql
CREATE INDEX idx_transactions_date_account
  ON transactions(created_date, account_id);
```

**Order matters in composite indexes.** The column with the most selective filter should come first. `created_date >= SYSDATE - 30` eliminates the bulk of rows up front, so it leads.

## Step 3: Verify with the optimizer

After adding the index, I ran `EXPLAIN PLAN` again. The full table scan was gone, replaced with an **INDEX RANGE SCAN**. Query time dropped to ~500ms.

## Takeaways

- **Always start with `EXPLAIN PLAN`** — guessing at optimizations without understanding what the DB is actually doing is a losing game.
- **Composite index column order matters.** Lead with the most selective predicate.
- **Measure, don't assume.** Even after adding the index, I ran benchmarks with real production-like data volumes before calling it done.

Small wins like this add up. When you're running a query millions of times a day, 7.5 seconds per call translates to real infrastructure cost — and a much better experience for everyone downstream.
