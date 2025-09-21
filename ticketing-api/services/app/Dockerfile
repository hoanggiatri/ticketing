# ---- build stage
FROM golang:1.24.4 AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/app ./cmd/app

# ---- run stage (distroless nhỏ gọn)
FROM gcr.io/distroless/base-debian12
ENV APP_HTTP_ADDR=:8080
EXPOSE 8080
COPY --from=builder /bin/app /app
ENTRYPOINT ["/app"]
