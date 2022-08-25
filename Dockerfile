FROM python:3.8-slim-buster as builder
MAINTAINER Hyesun Yoo <yoohs7974@gmail.com>

# Set working directory
COPY requirements.txt .

# Core linux dependencies.
# Python dependencies
# build-essential
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gcc \
    cmake \
    unzip && \
    apt-get clean && \
    pip3 install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove gcc


FROM python:3.8-slim-buster as app

COPY --from=builder /usr/local /usr/local

ENV PATH=/usr/local/bin:$PATH

WORKDIR /src
COPY ./ /src/

# Gunicorn
CMD ["gunicorn", "--worker-class", "eventlet", "-w", "1", "-b", "0.0.0.0:5005", "wsgi:app"]

EXPOSE 5005
