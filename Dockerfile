FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/github.com/JamesClonk/web-container
COPY . .
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/web-container

FROM scratch
LABEL maintainer="JamesClonk <jamesclonk@jamesclonk.ch>"
COPY --from=builder /go/bin/web-container /go/bin/web-container
EXPOSE 8080
CMD ["/go/bin/web-container"]
