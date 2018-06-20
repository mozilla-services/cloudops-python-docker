FROM python:3

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 18.03.1-ce


COPY requirements.txt ./

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    tar -x -f docker.tgz --strip-components 1 -C /usr/local/bin && \
    rm -f docker.tgz && \
    docker -v
    
    
RUN pip install --no-cache-dir -r requirements.txt
