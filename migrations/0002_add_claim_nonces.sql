CREATE TABLE IF NOT EXISTS claim_nonces (
    nonce           TEXT PRIMARY KEY,
    github_url      TEXT NOT NULL,
    stellar_address TEXT NOT NULL,
    expires_at      TIMESTAMPTZ NOT NULL,
    verified        BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS idx_claim_nonces_github_url
    ON claim_nonces (github_url);
