FROM golang:1.13-alpine3.10 as builder

WORKDIR /
COPY main.go go.mod /
ENV CGO_ENABLED 0
RUN go build .

# A payload shuttle image
#
FROM scratch as runner
LABEL maintainer="mark@philoserf.com"

COPY --from=builder shuttle /
ENTRYPOINT ["/shuttle"]

COPY payload /payload
