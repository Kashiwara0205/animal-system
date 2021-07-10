
# syntax=docker/dockerfile:1
FROM python:3.9.6-buster
COPY requirements.txt recommendation-system/requirements.txt
WORKDIR recommendation-system
RUN apt update
RUN apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8
RUN pip install -r requirements.txt

# シンボリックリンクをはらないとmecabが動かない
RUN ln -s /etc/mecabrc /usr/local/etc/mecabrc