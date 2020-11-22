# libjq static libraries for alpine
FROM flant/jq:b6be13d5-buster as libjq

FROM golang:1.15-buster as builder

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN CGO_ENABLED=1 \
    CGO_CFLAGS="-I$(pwd)/libjq/include" \
    CGO_LDFLAGS="-L$(pwd)/libjq/lib" \
    go build example.go

FROM debian:buster
COPY --from=builder /app/example /
ENTRYPOINT ["/example"]

