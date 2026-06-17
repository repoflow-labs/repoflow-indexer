CREATE EXTENSION IF NOT EXISTS ltree;

CREATE TABLE IF NOT EXISTS repo_claims (
    repo_id       BYTEA PRIMARY KEY,
    github_url    TEXT NOT NULL UNIQUE,
    owner_address TEXT NOT NULL,
    claimed_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    tx_hash       TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS repo_dependencies (
    repo_id     BYTEA NOT NULL REFERENCES repo_claims(repo_id),
    dep_repo_id BYTEA NOT NULL REFERENCES repo_claims(repo_id),
    weight_bps  INTEGER NOT NULL CHECK (weight_bps > 0 AND weight_bps <= 10000),
    PRIMARY KEY (repo_id, dep_repo_id)
);

CREATE TABLE IF NOT EXISTS funding_vaults (
    repo_id         BYTEA PRIMARY KEY REFERENCES repo_claims(repo_id),
    token_address   TEXT NOT NULL,
    total_deposited NUMERIC(38,7) NOT NULL DEFAULT 0,
    total_withdrawn NUMERIC(38,7) NOT NULL DEFAULT 0,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dep_tree_paths (
    repo_id     BYTEA NOT NULL,
    ancestor_id BYTEA NOT NULL,
    depth       INTEGER NOT NULL,
    path        ltree NOT NULL,
    PRIMARY KEY (repo_id, ancestor_id)
);
CREATE INDEX IF NOT EXISTS idx_dep_tree_gist ON dep_tree_paths USING GIST (path);

CREATE TABLE IF NOT EXISTS indexer_cursors (
    contract_id TEXT PRIMARY KEY,
    last_ledger BIGINT NOT NULL DEFAULT 0,
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS claim_nonces (
    nonce           TEXT PRIMARY KEY,
    github_url      TEXT NOT NULL,
    stellar_address TEXT NOT NULL,
    expires_at      TIMESTAMPTZ NOT NULL,
    verified        BOOLEAN NOT NULL DEFAULT FALSE
);