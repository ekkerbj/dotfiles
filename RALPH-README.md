# RALPH README

This document defines a recommended `prd.json` format for use with `ralph`.

## Ralph Compatibility

`ralph` currently enforces only this structure:
- top-level `backlog` array
- `passes` boolean on each backlog item

Completion is reached when no backlog entry has `"passes": false`.

## Recommended PRD Format (Behavior-First)

Each backlog entry should represent a feature or behavior change, not implementation steps.

Recommended fields:
- `id`: stable identifier (`F-001`, `F-002`)
- `feature`: short business-facing name
- `behavior_change`: what changes for users
- `user_value`: why this matters
- `acceptance_tests`: human-readable Given/When/Then scenarios
- `passes`: set to `true` only after verification
- `notes` (optional): constraints, edge cases, rollout details
- `dependencies` (optional): related feature IDs

## Acceptance Test Format

Use plain language for acceptance tests:
- `given`: starting context
- `when`: action or event
- `then`: expected observable result

Tests should describe externally visible behavior and avoid implementation details.

## Example `prd.json`

```json
{
  "meta": {
    "project": "example-product",
    "updated_at": "2026-03-05"
  },
  "backlog": [
    {
      "id": "F-001",
      "feature": "Session expiry warning",
      "behavior_change": "Users receive a warning 2 minutes before session expiry and can extend the session without losing work.",
      "user_value": "Reduces surprise logouts and lost input.",
      "acceptance_tests": [
        {
          "id": "AT-001",
          "given": "a logged-in user with an active session",
          "when": "the session reaches 2 minutes remaining",
          "then": "a warning banner is shown with an 'Extend session' action"
        },
        {
          "id": "AT-002",
          "given": "the warning banner is visible",
          "when": "the user selects 'Extend session'",
          "then": "the session is renewed and the warning banner disappears"
        },
        {
          "id": "AT-003",
          "given": "the warning banner is visible",
          "when": "the user takes no action and the session expires",
          "then": "the user is signed out and redirected to the login page"
        }
      ],
      "passes": false,
      "notes": "Behavior must match on desktop and mobile."
    },
    {
      "id": "F-002",
      "feature": "Search with typo tolerance",
      "behavior_change": "Search returns relevant results for minor misspellings.",
      "user_value": "Users find results faster without exact spelling.",
      "acceptance_tests": [
        {
          "id": "AT-004",
          "given": "a catalog containing 'notebook'",
          "when": "a user searches for 'notebok'",
          "then": "results include 'notebook' in the top result set"
        }
      ],
      "passes": false
    }
  ]
}
```

## Authoring Rules

- Define each entry as an outcome, not a coding step.
- Keep one primary behavior change per entry.
- Ensure acceptance tests are specific and observable.
- Acceptance tests should be automated and put into the test step of the build
- Set `passes` to `true` only after all listed acceptance tests are verified.
- Update ADRs when architectural decisions are made.
