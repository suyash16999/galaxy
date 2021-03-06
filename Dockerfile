FROM golang:1.13.5-alpine3.10
WORKDIR /build
COPY . .
#RUN apk --no-cache add build-base
RUN GOOS=linux CGO_ENABLED=0 go build -a -mod=vendor -ldflags '-s -w -extldflags "-static"' -o galaxy .

FROM alpine:3.10
RUN apk --no-cache add ca-certificates
WORKDIR /galaxy
COPY --from=0 /build/galaxy .
CMD ["./galaxy", "runner"]