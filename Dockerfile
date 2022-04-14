FROM golang:1.17.8-alpine3.15 as dev
ENV GO111MODULE=on
WORKDIR /usr/src/app
COPY ./go.mod ./go.sum ./
RUN go mod download
COPY . .

FROM dev as build-dbg
ENV CGO_ENABLED=0
RUN go get github.com/go-delve/delve/cmd/dlv
RUN go build -gcflags="-N -l" -o /usr/local/bin/checkimage cmd/checkimage/main.go

FROM alpine:3.15.0 as deploy-dbg
COPY --from=build-dbg /go/bin/dlv /usr/local/bin/dlv
COPY --from=build-dbg /usr/local/bin/checkimage /usr/local/bin/checkimage
