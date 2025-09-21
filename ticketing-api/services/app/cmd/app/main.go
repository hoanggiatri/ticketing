package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"github.com/labstack/echo/v4"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	addr := os.Getenv("APP_HTTP_ADDR")
	if addr == "" {
		addr = ":8080"
	}

	e := echo.New()
	e.GET("/healthz", func(c echo.Context) error { return c.String(http.StatusOK, "ok") })
	e.GET("/metrics", echo.WrapHandler(promhttp.Handler()))

	go func() {
		if err := e.Start(addr); err != nil && err != http.ErrServerClosed {
			log.Fatalf("start: %v", err)
		}
	}()

	<-ctx.Done()
	_ = e.Shutdown(context.Background())
}
