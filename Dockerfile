FROM golang:1 as golang

RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login

FROM python:3

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.03.1-ce


COPY requirements.txt ./
COPY --from=golang /go/bin/docker-credential-ecr-login /usr/local/bin/docker-credential-ecr-login

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar -x -f docker.tgz --strip-components 1 -C /usr/local/bin && \
    rm -f docker.tgz && \
    docker -v
    
    
RUN pip install --no-cache-dir -r requirements.txt && pip freeze
