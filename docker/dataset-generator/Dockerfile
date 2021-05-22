FROM nickgryg/alpine-pandas:3.9.4

RUN mkdir /entrypoint
WORKDIR /entrypoint

COPY ./app.py .
COPY ../../../dataset.csv .

ENTRYPOINT python3 app.py