FROM python:rc-alpine

RUN pip3 install flask
RUN pip3 install pymongo

RUN mkdir /entrypoint
WORKDIR /entrypoint

COPY ./app.py .

ENTRYPOINT python3 app.py