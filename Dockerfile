FROM python:3.9-alpine3.17
EXPOSE 8000
WORKDIR /project/
COPY requirements.txt .
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add mariadb-connector-c-dev
RUN pip3 install --upgrade pip \
    && pip3 install -r requirements.txt --no-cache-dir
RUN apk del build-deps

COPY ./project-v2/ .
COPY run.sh .
RUN chmod +x run.sh
CMD ./run.sh
