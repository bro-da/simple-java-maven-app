FROM alpine
RUN apk add --no-cache python3

WORKDIR /app
COPY ./ .
