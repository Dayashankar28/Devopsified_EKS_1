FROM golang:1.24rc2 AS base

WORKDIR /app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o main .
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o main .

FROM gcr.io/distroless/static-debian12

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8089

CMD ["./main"]
