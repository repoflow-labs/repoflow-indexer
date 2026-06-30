# repoflow-indexer

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/repoflow-labs/repoflow-indexer/actions/workflows/ci.yml/badge.svg)](https://github.com/repoflow-labs/repoflow-indexer/actions/workflows/ci.yml)
[![Stellar](https://img.shields.io/badge/network-Stellar-black)](https://stellar.org)
[![Rust](https://img.shields.io/badge/rust-1.77+-orange.svg)](https://www.rust-lang.org)

Soroban RPC event indexer, REST API backend, and GitHub OAuth proof service for the RepoFlow protocol on Stellar.

## Architecture

Soroban RPC (getEvents) → Event Processor → PostgreSQL (sqlx)
→ Axum REST API  → Frontend / SDK consumersGitHub OAuth → Nonce Generation (HMAC-SHA256) → Verification Worker → On-chain Claim

Key tables: `repo_claims` | `repo_dependencies` | `funding_vaults` | `dep_tree_paths` | `indexer_cursors`

## Tech Stack

| Component | Technology | Version |
|---|---|---|
| Runtime | Tokio | 1.x |
| HTTP framework | Axum | 0.7 |
| Database | PostgreSQL + SQLx | 15+ / 0.8 |
| GitHub client | Octocrab | 0.41 |
| Smart contract layer | Soroban RPC | Futurenet |
| Language | Rust | 1.77+ |

## Prerequisites

| Tool | Version | Install |
|---|---|---|
| Rust | 1.77+ | https://rustup.rs |
| PostgreSQL | 15+ | https://postgresql.org |
| Docker | latest | https://docker.com |
| stellar-cli | latest | cargo install stellar-cli |

## Local Setup

```bash
git clone https://github.com/repoflow-labs/repoflow-indexer
cd repoflow-indexer
cp .env.example .env
createdb repoflow_dev
cargo run --bin migrate
cargo run --bin server
```

## API Endpoints

| Method | Path | Description |
|---|---|---|
| GET | /repos/:id | Repo claim detail and ownership state |
| GET | /repos/:id/dependencies | Full dependency tree (ltree, depth 5) |
| GET | /repos/:id/funding | Vault balance and funding history |
| POST | /auth/github | GitHub OAuth initiation |
| POST | /claim/generate-nonce | Generate HMAC-SHA256 ownership nonce |
| POST | /claim/verify | Trigger GitHub API nonce verification |

## Related Repos

| Repo | Role |
|---|---|
| [repoflow-contract](https://github.com/repoflow-labs/repoflow-contract) | Soroban smart contract — on-chain source of truth |
| [repoflow-app](https://github.com/repoflow-labs/repoflow-app) | Next.js frontend consuming this API |
| [repoflow-sdk](https://github.com/repoflow-labs/repoflow-sdk) | TypeScript SDK wrapping contract + API |
