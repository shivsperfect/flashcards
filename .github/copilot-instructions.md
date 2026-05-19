After each completed task, run `make build` in the project root to verify the output.
...

## Build & test
- Build: `make build`
- Run: `make run`
- Tests: `go test ./...`
- Single test: `go test ./services -run TestName` (adjust package/test name)

## High-level architecture
- `cmd/main.go` wires config, repositories, services, and handlers, then registers routes with `gorilla/mux` plus CORS/JSON middleware and the `/health` route.
- `config` loads `.env` via `godotenv`; `DB_URL` is required and `PORT` defaults to `8080`.
- Each domain (todos, notes) follows `models` → `db` (Postgres repo) → `services` (validation/business rules) → `handlers` (HTTP JSON).
- Postgres schema/migrations live in `supabase/migrations` and use the `gocourse` schema.

## Key conventions
- Routes use plural resources with numeric ID regexes: `/{resource}/{id:[0-9]+}`.
- Services trim input strings, enforce max length 255, and require at least one field on updates.
- Repositories build dynamic update maps and return not-found errors in the form `<resource> with id %d not found`.
- Handlers map not-found errors to HTTP 404 and always return JSON (`{"error": "..."}` on failures).
- Tables use `createdAt`/`updatedAt` camelCase columns and JSON fields.
