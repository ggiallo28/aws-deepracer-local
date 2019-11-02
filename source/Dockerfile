FROM docker:stable

COPY . .

RUN apk update
RUN apk add python3 python3-dev make automake gcc g++ subversion

RUN pip3 install pandas urllib3==1.24.3 PyYAML==3.13 ipython
RUN pip3 install -U sagemaker-python-sdk