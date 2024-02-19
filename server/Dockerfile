FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y \
    build-essential \ 
    libpq-dev \
    nodejs \
    vim \
    texlive \
    texlive-latex-extra \
    imagemagick=8:6.9.11.60* \
    ghostscript

RUN mkdir /app
WORKDIR /app
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock
ADD . /app

COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# ImageMagickでPDFを扱うための設定
RUN sed -i '/<policy domain="coder" rights="none" pattern="PDF" \/>/d' /etc/ImageMagick-6/policy.xml
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3010

CMD [ "rails","server","-b","0.0.0.0","-p","3000"]