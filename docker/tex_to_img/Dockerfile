FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    texlive=2021.20220204-1 \
    texlive-latex-extra \
    imagemagick=8:6.9.11.60*

WORKDIR /src
COPY ../../src /src
RUN mkdir -p /src/tmp

RUN pip3 install -r requirements.txt
RUN sed -i '/<policy domain="coder" rights="none" pattern="PDF" \/>/d' /etc/ImageMagick-6/policy.xml
COPY . /app
CMD ["python3", "app.py"]
