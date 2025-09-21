.PHONY: up down build test migrate

up:
	docker compose -f infra/docker-compose.yml up -d --build

down:
	docker compose -f infra/docker-compose.yml down -v

build:
	cd services/app && go build ./...

test:
	go test ./... -race -count=1

# dùng container migrate (tuỳ chọn, phần 9 bên dưới)
migrate:
	docker run --rm --network host \
	 -v $(PWD)/services/app/internal/store/pg/migrations:/migrations \
	 migrate/migrate -path=/migrations \
	 -database "postgres://hgt:hgt@localhost:5432/ticketing?sslmode=disable" up
