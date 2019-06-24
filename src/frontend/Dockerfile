FROM golang:1.12-alpine as builder
RUN apk add --no-cache ca-certificates git && \
      wget -qO/go/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 && \
      chmod +x /go/bin/dep

ENV PROJECT github.com/GoogleCloudPlatform/microservices-demo/src/frontend
WORKDIR /go/src/$PROJECT
#
# restore dependencies
COPY src/frontend/Gopkg.* ./
RUN dep ensure --vendor-only -v
COPY src/frontend/. .
RUN go install .

## Introduce vulnerabilities below uncomment and comment appropriately

#FROM alpine as release
#RUN apk add --no-cache ca-certificates busybox-extras net-tools bind-tools
#use this to add vulnerabilities
#FROM alpine:3.4 as release
#RUN apk add --no-cache ca-certificates net-tools bind-tools freetype zlib curl

WORKDIR /frontend
COPY --from=builder /go/bin/frontend /frontend/server
COPY src/frontend/templates ./templates
COPY src/frontend/static ./static
EXPOSE 8080
#EXPOSE 22
#COPY --from=samgabrail/networktools:latest /app/key/throwAway.pem ./throwAway.pem
#ENV PASSWORD "LightningMcQueen123"
ENTRYPOINT ["/frontend/server"]
