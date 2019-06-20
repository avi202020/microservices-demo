##FROM golang:1.12-alpine as builder
FROM golang:1.10-alpine as builder
RUN apk add --no-cache ca-certificates git && \
#      wget -qO/go/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 && \
      wget -qO/go/bin/dep https://github.com/golang/dep/releases/download/v0.3.0/dep-linux-amd64.zip && \
      chmod +x /go/bin/dep

ENV PROJECT github.com/GoogleCloudPlatform/microservices-demo/src/frontend
WORKDIR /go/src/$PROJECT

# restore dependencies
COPY src/frontend/Gopkg.* ./
RUN dep ensure --vendor-only -v
COPY src/frontend/. .
RUN go install .

FROM alpine as release
RUN apk add --no-cache ca-certificates \
    busybox-extras net-tools bind-tools
WORKDIR /frontend
COPY --from=builder /go/bin/frontend /frontend/server
COPY src/frontend/templates ./templates
COPY src/frontend/static ./static
EXPOSE 8080
EXPOSE 22
ENTRYPOINT ["/frontend/server"]
