FROM golang:1.18 AS builder

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    build-essential \
    openjdk-11-jdk \
    libc6 \
    libc6-dev \
    zlib1g-dev \
    libz-dev \
    && apt-get clean

RUN curl -LO "https://github.com/bazelbuild/bazelisk/releases/download/v1.10.1/bazelisk-linux-amd64" \
    && mv bazelisk-linux-amd64 /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

WORKDIR /app

COPY . .

RUN bazel build //:my_go_app --verbose_failures --sandbox_debug

FROM gcr.io/distroless/base-debian10

COPY --from=builder /app/bazel-bin/my_go_app_/my_go_app /my_go_app

CMD ["/my_go_app"]
