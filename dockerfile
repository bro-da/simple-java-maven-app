FROM maven
RUN apk add --no-cache python2 g++ make
WORKDIR /app
COPY ./*.jar .