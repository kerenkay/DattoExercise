FROM python:3.7-alpine

ENV BITDAM=21
ENV PYTHONUNBUFFERED 1 

RUN pip install --upgrade pip
RUN pip install virtualenv
RUN python -m virtualenv venv

COPY requirements.txt .
RUN apk update && apk add make automake gcc g++ subversion python3-dev
RUN /venv/bin/pip install -r requirements.txt

COPY microservice ./microservice/
CMD ["/venv/bin/python", "microservice/main.py"]
