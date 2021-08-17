FROM golang:1.16 as build
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/tcp-echo .

FROM scratch as bin
COPY --from=build /out/tcp-echo /

EXPOSE 5000
ENTRYPOINT [ "/tcp-echo" ]