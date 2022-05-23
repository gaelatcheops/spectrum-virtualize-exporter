FROM quay.io/prometheus/golang-builder:1.18-base as builder

WORKDIR /build

COPY . .
RUN go get -v -t -d ./...
RUN CGO_ENABLED=0 go build -o spectrum-virtualize-exporter .

FROM scratch
WORKDIR /

COPY --from=builder /build/spectrum-virtualize-exporter /

EXPOSE 9119
ENTRYPOINT ["/spectrum-virtualize-exporter"]
CMD ["--config.file=/spectrumVirtualize.yml"]
