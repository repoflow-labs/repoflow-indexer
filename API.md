# API Reference

Base URL: `http://localhost:3001`

## Repos

### GET /repos/:id

Fetch claim details and ownership state for a repository.

**Parameters**

| Name | Type | In | Description |
|------|------|----|-------------|
| `id` | string | path | SHA-256 hex hash of the canonical repo URL |

**Response** `200 OK`

```json
{
  "repoId": "abc123...",
  "githubUrl": "https://github.com/org/repo",
  "ownerAddress": "G...",
  "claimedAt": "2026-05-01T12:00:00Z",
  "txHash": "0x..."
}
```

**Errors** `404 Not Found` — repo not claimed yet

### GET /repos/:id/dependencies

Fetch the full dependency tree for a repository (ltree traversal, max depth 5).

**Parameters**

| Name | Type | In | Description |
|------|------|----|-------------|
| `id` | string | path | SHA-256 hex hash of the repo |

**Response** `200 OK`

```json
[
  {
    "repoId": "abc...",
    "githubUrl": "https://github.com/org/a",
    "ownerAddress": "G...",
    "weightBps": 6000,
    "depth": 0,
    "children": [
      {
        "repoId": "def...",
        "githubUrl": "https://github.com/org/b",
        "ownerAddress": "G...",
        "weightBps": 4000,
        "depth": 1,
        "children": []
      }
    ]
  }
]
```

### GET /repos/:id/funding

Fetch the funding vault balance and history for a repository.

**Parameters**

| Name | Type | In | Description |
|------|------|----|-------------|
| `id` | string | path | SHA-256 hex hash of the repo |

**Response** `200 OK`

```json
{
  "repoId": "abc...",
  "tokenAddress": "G...",
  "totalDeposited": "1000.0000000",
  "totalWithdrawn": "200.0000000",
  "claimable": "800.0000000"
}
```

## Auth

### POST /auth/github

Initiate GitHub OAuth flow.

**Request Body**

```json
{
  "redirectUri": "http://localhost:3000/dashboard"
}
```

**Response** `200 OK`

```json
{
  "authUrl": "https://github.com/login/oauth/authorize?..."
}
```

## Claim

### POST /claim/generate-nonce

Generate an HMAC-SHA256 ownership proof nonce.

**Request Body**

```json
{
  "stellarAddress": "G...",
  "githubUrl": "https://github.com/org/repo"
}
```

**Response** `201 Created`

```json
{
  "nonce": "a1b2c3d4...",
  "expiresAt": "2026-05-02T12:00:00Z"
}
```

### POST /claim/verify

Trigger the GitHub API to verify a nonce has been posted to the target repository.

**Request Body**

```json
{
  "nonce": "a1b2c3d4...",
  "githubUrl": "https://github.com/org/repo"
}
```

**Response** `200 OK`

```json
{
  "verified": true
}
```
