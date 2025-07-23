# Start from the official Go base image
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
COPY main.go ./
COPY middlewares ./middlewares
COPY pkg ./pkg
COPY static ./static
COPY test_data_dir ./test_data_dir

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o fi-mcp-dev .

# Use a minimal image for the runtime
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/fi-mcp-dev .
COPY --from=builder /app/static ./static
COPY --from=builder /app/test_data_dir ./test_data_dir

# Pass environment variable to allow dynamic port binding
ENV PORT=8080

EXPOSE 8080
CMD ["./fi-mcp-dev"]