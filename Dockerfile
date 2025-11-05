# Build stage
FROM rust:latest as builder

WORKDIR /build

COPY . .

RUN make maxperf

# Runtime stage
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/target/maxperf/reth-bsc /usr/local/bin/reth-bsc

ENTRYPOINT ["reth-bsc"]
