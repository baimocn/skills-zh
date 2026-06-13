---
name: data-activator
description: "Proactive data architecture router — detects database, API, and data modeling intent. Analyzes existing schemas, discusses SQL vs NoSQL trade-offs, ORM selection, API design patterns, and query optimization strategies. Triggers on schema files, migration files, ORM configs, API route definitions, GraphQL schemas, and any data layer work."
license: MIT
---

# Data Activator

A collaborative activator skill that routes database, API, and data architecture work to
specialized data skills. It detects intent, analyzes existing data models, facilitates
trade-off discussions, and coordinates sub-skills to deliver production-ready data layers.

## 核心设计哲学 (Core Philosophy)

1. **Always analyze before proposing.** Never suggest schema changes without first reading
   and diagramming the existing data model.
2. **Show, then build.** Present ASCII entity-relationship diagrams and schema previews
   before generating any code.
3. **Trade-offs are mandatory.** Every recommendation must include at least two alternatives
   with pros and cons. Data decisions are expensive to reverse.
4. **Access patterns drive design.** Ask about read/write ratios, query shapes, and
   concurrency needs before choosing a database or schema shape.
5. **Migration-aware.** Every schema change must consider backward compatibility, zero-downtime
   deploys, and rollback strategies.

## Managed Data Skills

| Skill ID                   | Purpose                                      |
| -------------------------- | -------------------------------------------- |
| database-schema-designer   | Schema design for PostgreSQL, MySQL, MongoDB |
| orm-code-generator         | ORM code via Prisma, Drizzle, TypeORM, Sequelize |
| query-performance-analyzer | Query optimization, indexing, EXPLAIN plans  |
| rest-api-generator         | REST API scaffolding from OpenAPI specs      |
| api-schema-validator       | OpenAPI, JSON Schema, GraphQL validation     |
| sync-server-db             | Database sync between remote server and local|

---

## Signal Detection

### Group A: File Signals

Trigger data-activator when the user opens or references any of these file patterns:

```
*.sql                          # Raw SQL files
schema.prisma                  # Prisma schema
prisma/schema.prisma           # Prisma schema (nested)
drizzle.config.*               # Drizzle ORM config
*.graphql                      # GraphQL schema files
*.gql                          # GraphQL (short extension)
migrations/**                  # Migration directories
models/**                      # Model directories
entities/**                    # Entity directories (TypeORM)
*.entity.ts                    # TypeORM entity files
*.model.ts                     # Model definition files
ormconfig.*                    # TypeORM / Sequelize config
knexfile.*                     # Knex config
**/database/**                 # Database utility directories
**/api/routes/**               # API route definitions
**/api/handlers/**             # API handler files
.env (containing DATABASE_URL) # Environment with DB connection
docker-compose.yml (with db)   # Compose files defining database services
```

### Group B: User Intent Keywords

Detect these phrases and synonyms in user messages:

```
Database/schema triggers:
  "database", "schema", "table", "column", "migration", "index",
  "foreign key", "constraint", "primary key", "relation", "model",
  "entity", "field", "type", "enum", "junction table"

API triggers:
  "API endpoint", "REST", "GraphQL", "tRPC", "OpenAPI", "Swagger",
  "request", "response", "route", "handler", "controller", "middleware",
  "pagination", "filtering", "sorting", "rate limit"

Performance triggers:
  "query slow", "N+1", "optimize", "index", "explain", "performance",
  "latency", "throughput", "connection pool", "cache", "deadlock"

ORM triggers:
  "Prisma", "Drizzle", "TypeORM", "Sequelize", "MikroORM", "Knex",
  "migration generate", "seed", "ORM", "query builder"

Operation triggers:
  "create table", "alter table", "drop table", "insert", "update",
  "select", "join", "aggregate", "transaction", "rollback"
```

### Group C: Project State Assessment

Evaluate the current project state to determine the starting point:

```
State: No database detected
  → Design from scratch
  → Ask about requirements first (see Discussion Protocol below)
  → Route to database-schema-designer

State: Existing schema found (schema.prisma, migrations/, *.sql)
  → Read and analyze the full schema
  → Build ASCII ER diagram
  → Identify potential issues (missing indexes, no timestamps, no soft delete)
  → Route to database-schema-designer for improvements

State: Slow queries reported
  → Route to query-performance-analyzer
  → Ask for EXPLAIN output or slow query log
  → Check ORM code for N+1 patterns

State: API routes exist but no validation
  → Route to api-schema-validator
  → Generate OpenAPI spec from existing routes

State: Schema exists but no ORM code
  → Route to orm-code-generator with existing schema as input
```

### Group D: Data Pattern Recognition

Match the project's dominant pattern to a baseline architecture: CRUD apps (blog, e-commerce, SaaS) get PostgreSQL + Prisma + REST with normalized schema and cursor pagination. Real-time apps (chat, collaboration) get PostgreSQL + Drizzle + tRPC/WebSocket with event sourcing. Content-heavy projects (CMS, docs) get PostgreSQL + headless CMS pattern with JSONB and full-text search. Analytics/reporting gets ClickHouse or TimescaleDB with denormalized star schema and materialized views. Social graphs get PostgreSQL recursive CTEs at small scale, Neo4j/Neptune at large scale. High-scale SaaS gets read replicas + Redis cache + PgBouncer connection pooling + table partitioning.

---

## 协作讨论协议 (Collaborative Discussion Protocol)

### Phase 1: Data Architecture Brief

When triggered, produce an architecture brief that includes:

```text
╔══════════════════════════════════════════════════════════╗
║              DATA ARCHITECTURE BRIEF                     ║
╠══════════════════════════════════════════════════════════╣
║  Project: [name]                                         ║
║  State:   [new schema | existing | needs optimization]   ║
║  Stack:   [detected DB + ORM + API style]                ║
║  Pattern: [CRUD | real-time | content | analytics | ...] ║
╚══════════════════════════════════════════════════════════╝
```

If an existing schema is found, render an ASCII ER diagram:

```text
  ┌──────────────┐       ┌──────────────────┐       ┌──────────────┐
  │    users      │       │    orders         │       │  products     │
  ├──────────────┤       ├──────────────────┤       ├──────────────┤
  │ id       PK  │──┐    │ id           PK  │   ┌──│ id       PK  │
  │ email        │  └───>│ user_id      FK  │   │  │ name         │
  │ name         │       │ status           │   │  │ price        │
  │ created_at   │       │ total            │   │  │ stock        │
  └──────────────┘       │ created_at       │   │  │ created_at   │
                         └──────────────────┘   │  └──────────────┘
                                                │
                         ┌──────────────────┐   │
                         │ order_items       │   │
                         ├──────────────────┤   │
                         │ id           PK  │   │
                         │ order_id     FK  │───┘
                         │ product_id   FK  │
                         │ quantity         │
                         │ unit_price       │
                         └──────────────────┘
```

### Phase 2: Requirements Gathering

Ask these questions (adapt based on context): Read/write ratio (read-heavy, write-heavy, or balanced?), expected data volume within 1 year (hundreds/thousands/millions/billions of rows), consistency needs (strong ACID vs eventual consistency), existing cloud provider and DB services (RDS, Supabase, PlanetScale, Neon, Turso, self-hosted), team ORM familiarity, and API consumers (internal frontend, mobile, third-party).

### Phase 3: Trade-off Discussion

Present trade-offs as structured comparison tables:

```text
SQL vs NoSQL:
┌──────────────┬─────────────────────────┬─────────────────────────┐
│ Factor       │ SQL (PostgreSQL)        │ NoSQL (MongoDB)         │
├──────────────┼─────────────────────────┼─────────────────────────┤
│ Schema       │ Strict, enforced        │ Flexible, schemaless    │
│ Joins        │ Native, efficient       │ Manual, application-side│
│ Transactions │ Full ACID               │ Limited (document-level)│
│ Scaling      │ Vertical + read replica │ Horizontal (sharding)   │
│ Best for     │ Structured data, rels   │ Variable shapes, rapid  │
│              │                         │ prototyping             │
└──────────────┴─────────────────────────┴─────────────────────────┘

REST vs GraphQL vs tRPC:
┌──────────────┬─────────────┬──────────────┬──────────────┐
│ Factor       │ REST        │ GraphQL      │ tRPC         │
├──────────────┼─────────────┼──────────────┼──────────────┤
│ Over/under   │ Over-fetch  │ Exact query  │ Exact query  │
│ fetch        │ common      │              │              │
│ Type safety  │ Manual      │ Codegen      │ Native TS    │
│ Caching      │ HTTP cache  │ Complex      │ Client-side  │
│ Learning     │ Low         │ Medium       │ Low (TS)     │
│ Best for     │ Public APIs │ Complex UIs  │ Full-stack TS│
└──────────────┴─────────────┴──────────────┴──────────────┘

ORM Comparison:
┌──────────────┬─────────────┬──────────────┬──────────────┬──────────────┐
│ Factor       │ Prisma      │ Drizzle      │ TypeORM      │ Sequelize    │
├──────────────┼─────────────┼──────────────┼──────────────┼──────────────┤
│ Type safety  │ Excellent   │ Excellent    │ Good         │ Moderate     │
│ SQL control  │ Limited     │ High         │ Medium       │ Medium       │
│ Migration    │ Auto-gen    │ SQL-based    │ Auto-gen     │ Auto-gen     │
│ Performance  │ Good        │ Excellent    │ Moderate     │ Moderate     │
│ Learning     │ Low         │ Medium       │ Medium       │ Medium       │
│ Ecosystem    │ Largest     │ Growing      │ Mature       │ Mature       │
└──────────────┴─────────────┴──────────────┴──────────────┴──────────────┘
```

---

## Schema Preview & Code Generation

Before generating any schema, always show a preview:

```text
Proposed schema preview:

-- users table
CREATE TABLE users (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email       VARCHAR(255) NOT NULL UNIQUE,
  name        VARCHAR(100) NOT NULL,
  avatar_url  TEXT,
  role        VARCHAR(20) NOT NULL DEFAULT 'user',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role  ON users(role);

Shall I proceed with generating this schema?
(A) Accept as-is
(B) Modify fields
(C) Add soft delete (deleted_at)
(D) Show alternative (MongoDB document shape)
```

Equivalent Prisma and Drizzle previews should also be generated alongside raw SQL, using the
same field names and types. Always present all three formats (SQL, Prisma, Drizzle) when the
user's ORM preference is known, or all formats when it is not.

---

## Decision Patterns

### Pattern: Simple CRUD (e-commerce, blog, SaaS)

```text
Stack:  PostgreSQL + Prisma + REST
Schema: Normalized, 3NF
API:    Express/Fastify + Zod validation
Auth:   JWT + middleware
Deploy: Single DB + read replica (later)

Mandatory additions:
  - created_at / updated_at on every table
  - Soft delete via deleted_at
  - UUID primary keys (not auto-increment)
  - Cursor-based pagination for list endpoints
  - Request validation via Zod schemas
```

### Pattern: Real-time (chat, multiplayer, live dashboards)

```text
Stack:  PostgreSQL + Drizzle + tRPC + WebSocket
Schema: Normalized with event log table
API:    tRPC subscriptions + REST fallback
Cache:  Redis for presence / ephemeral state

Mandatory additions:
  - Messages/events table with sequential bigint PK
  - Optimistic locking via version columns
  - Connection pooling (PgBouncer) with max 20 connections
  - Redis pub/sub for cross-instance WebSocket fanout
```

### Pattern: Content-heavy (CMS, documentation)

```text
Stack:  PostgreSQL + Prisma + REST + Elasticsearch
Schema: Hybrid — relational for structure, JSONB for content
API:    REST with rich filtering and full-text search

Mandatory additions:
  - content_blocks JSONB column for flexible content
  - Full-text search index (pg_trgm or tsvector)
  - Slug-based routing with unique constraint
  - Draft/Published status enum
  - Media assets table with S3 references
```

### Pattern: Analytics / Reporting

```text
Stack:  ClickHouse or TimescaleDB + Denormalized
Schema: Star schema with fact + dimension tables
API:    REST with aggregate endpoints
ETL:    Scheduled materialized view refresh

Mandatory additions:
  - Partitioning by date range
  - Materialized views for common aggregates
  - TTL policies for raw event data
  - Separate OLTP and OLAP databases
```

### Pattern: High-Scale SaaS

```text
Stack:  PostgreSQL + Prisma + REST + Redis + PgBouncer
Schema: Normalized with strategic denormalization
API:    REST with response caching headers

Mandatory additions:
  - Read replicas for reporting queries
  - Connection pooling (PgBouncer, max 100 connections)
  - Redis cache for hot reads (user sessions, feature flags)
  - Table partitioning for audit_logs, events
  - Background job queue for write-heavy operations
  - Rate limiting on public API endpoints
```

---

## 主动行为 (Proactive Behaviors)

### N+1 Query Detection

When reviewing ORM code, actively scan for these patterns:

```typescript
// BAD: N+1 query
const orders = await prisma.order.findMany();
for (const order of orders) {
  // Each iteration fires a separate query
  const user = await prisma.user.findUnique({ where: { id: order.userId } });
}

// GOOD: Eager loading
const orders = await prisma.order.findMany({
  include: { user: true },
});

// GOOD (Drizzle): Join query
const orders = await db
  .select()
  .from(ordersTable)
  .leftJoin(usersTable, eq(ordersTable.userId, usersTable.id));
```

### Index Recommendation

When a table has frequent WHERE/JOIN/ORDER BY clauses on non-indexed columns:

```text
Detected: Query on orders.status + orders.created_at without composite index.

Current query:
  SELECT * FROM orders WHERE status = 'pending' ORDER BY created_at DESC;

Recommendation:
  CREATE INDEX idx_orders_status_created
    ON orders(status, created_at DESC);

  -- This composite index covers both the WHERE clause and the sort,
  -- avoiding a filesort on large result sets.
```

### Migration Strategy

When schema changes are needed:

```text
Migration Strategy for adding "not null" column:

  Step 1: Add column as nullable
    ALTER TABLE users ADD COLUMN phone VARCHAR(20);

  Step 2: Backfill existing rows
    UPDATE users SET phone = '' WHERE phone IS NULL;

  Step 3: Add NOT NULL constraint (after backfill)
    ALTER TABLE users ALTER COLUMN phone SET NOT NULL;

  Step 4: Deploy application code that uses the new column

  Zero-downtime compatible: YES
  Rollback: Drop column in reverse migration
```

### API Validation Check

When unvalidated endpoints are detected:

```text
Warning: POST /api/orders has no request validation.

Recommended: Add Zod schema validation

  const createOrderSchema = z.object({
    items: z.array(z.object({
      productId: z.string().uuid(),
      quantity: z.number().int().positive(),
    })).min(1),
    shippingAddress: z.object({
      street: z.string().min(1),
      city: z.string().min(1),
      zip: z.string().regex(/^\d{5}(-\d{4})?$/),
    }),
  });
```

---

## 跨技能协作 (Cross-Activator Coordination)

| Trigger                                    | Coordinate With      | Purpose                            |
| ------------------------------------------ | -------------------- | ---------------------------------- |
| Database infrastructure provisioning       | devops-activator     | Docker, cloud DB setup, backups    |
| Admin dashboard data requirements          | design-activator     | Data grids, charts, CRUD UIs      |
| Authentication data model                  | devops-activator     | User auth tables, session storage  |
| API documentation generation               | rest-api-generator   | OpenAPI spec from existing routes  |
| Query performance issues in production     | query-performance-analyzer | EXPLAIN analysis, index advice |
| Schema needs to sync between environments  | sync-server-db       | Server-to-local DB sync           |

---

## 子技能调度逻辑 (Sub-Skill Routing)

Route requests as follows: Schema design requests go to database-schema-designer, then optionally to orm-code-generator. Slow query complaints go to query-performance-analyzer, then to database-schema-designer for index fixes. REST endpoint creation goes to rest-api-generator, then to api-schema-validator for OpenAPI spec generation. DB sync requests go to sync-server-db. Always discuss REST vs GraphQL trade-offs before routing GraphQL requests. When no ORM preference exists, suggest Prisma for new projects and Drizzle for teams wanting more SQL control.

---

## 输出模板 (Output Templates)

Use these templates for final deliverables. The New Project brief includes: detected pattern, volume assessment, API style recommendation, ASCII ER diagram, recommended stack (DB + ORM + API + validation + migrations), and a 5-step action plan (confirm schema, generate ORM, generate migrations, scaffold API routes, add seed data). The Optimization Report includes: issues found (N+1 queries, missing indexes, unpartitioned tables), recommendations ordered by impact with EXPLAIN analysis, and proposed SQL/ORM code for each fix.
