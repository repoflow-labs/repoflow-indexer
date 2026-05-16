# repoflow-indexer

[![CI](https://github.com/repoflow-labs/repoflow-indexer/actions/workflows/ci.yml/badge.svg)](https://github.com/repoflow-labs/repoflow-indexer/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Stellar](https://img.shields.io/badge/network-Stellar-black)](https://stellar.org)

Rust/Tokio event indexer and API backend for RepoFlow.

## Technical Architecture

```
Soroban RPC (getEvents) → Event Processor → PostgreSQL (sqlx)
                        → Axum REST API  → Frontend/SDK consumers
```

Data pipeline: RPC long-poll → idempotent event handler → ltree dep path materialization

Key tables: repo_claims | repo_dependencies | funding_vaults | dep_tree_paths | indexer_cursors

## Local Development Setup

| Tool | Version | Install Command |
|------|---------|-----------------|
| Rust | 1.77+ | rustup install 1.77 |
| PostgreSQL | 15+ | Docker: `docker run -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=repoflow_dev postgres:15` |
| Docker | latest | docker.com/downloads |
| stellar-cli | latest | `cargo install stellar-cli` |

Sequential CLI setup commands:

```bash
cargo build
createdb repoflow_dev
cargo run --bin migrate
cargo run --bin server
```

## Technology Stack

| Component | Technology | Version |
|-----------|------------|---------|
| Smart Contract | N/A | N/A |
| Backend | Rust/Tokio | 1.77+ |
| Backend | Axum | latest |
| Backend | sqlx | latest |
| Backend | PostgreSQL | 15+ |
| Frontend | N/A | N/A |
| Infrastructure | Docker | latest |
| Infrastructure | Stellar RPC | futurenet/testnet |

## Documentation

For detailed usage instructions, API reference, and architecture explanations, see the docs:

- [Protocol Overview](./docs/protocol.md)
- [Contract Reference](./docs/contract.md)
- [Indexer Guide](./docs/indexer.md)
- [SDK Reference](./docs/sdk.md)

## License

MIT License - see [LICENSE](LICENSE) for details.