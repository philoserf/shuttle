FROM golang:1.11-alpine3.8 as builder

WORKDIR /
COPY main.go go.mod /
ENV CGO_ENABLED 0
RUN go build -tags 'static' -ldflags '-extldflags "-static -fno-PIC"' .

# A payload shuttle image
#
FROM scratch as runner
LABEL maintainer="mark@philoserf.com"

COPY --from=builder shuttle /
ENTRYPOINT ["/shuttle"]

COPY payload /payload
