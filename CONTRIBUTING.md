# Contributing to repoflow-indexer

## Git Workflow

1. Fork the repository
2. Clone your fork: `git clone https://github.com/<your-username>/repoflow-indexer.git`
3. Add upstream: `git remote add upstream https://github.com/repoflow-labs/repoflow-indexer.git`
4. Create a feature branch: `git checkout -b feature/<scope>` or `git checkout -b fix/<scope>`

Branch naming conventions:
- `feature/<scope>` — new functionality
- `fix/<scope>` — bug fixes
- `docs/<scope>` — documentation updates
- `chore/<scope>` — maintenance tasks

**Never commit directly to main.**

Before submitting a PR:
1. Rebase on upstream/main: `git fetch upstream && git rebase upstream/main`
2. Merge commits are prohibited — squash or rebase your commits
3. Ensure all CI checks pass

## Commit Message Convention

Format: `<type>(<scope>): <imperative subject ≤72 chars>`

Types: feat | fix | docs | chore | test | refactor | perf

Scopes for this repo: api, db, indexer, github, ci, deps

Examples:
- `feat(api): add GET /repos/:id/dependencies endpoint`
- `fix(db): correct ltree path construction on SplitSet events`
- `chore(deps): upgrade sqlx to 0.8`
- `test(indexer): add integration test for event processor`
- `refactor(db): extract connection pooling to dedicated module`

Breaking changes: Append `BREAKING CHANGE: <description>` in the commit footer.

## PR Submission Requirements

- All CI checks pass before requesting review
- Integration test for every new API endpoint
- Closes # in PR description
- PR title follows Angular convention
- Minimum one maintainer approval before merge

## Development Setup

```bash
# Install dependencies
cargo build

# Create development database
createdb repoflow_dev

# Run migrations
cargo run --bin migrate

# Start development server
cargo run --bin server

# Run tests
cargo test

# Format check
cargo fmt --check

# Lint
cargo clippy -- -D warnings
```

## Code Style

- Follow Rust standard formatting (`cargo fmt`)
- Enable clippy lints (`cargo clippy -- -D warnings`)
- Use explicit lifetimes where clarity demands
- Document public APIs with doc comments
- Write async code with tokio runtime in mind