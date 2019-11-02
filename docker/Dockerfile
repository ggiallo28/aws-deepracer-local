FROM docker:stable

COPY ./source/sagemaker-python-sdk sagemaker-python-sdk
COPY ./configure_env.sh .

RUN apk update
RUN apk add python3 python3-dev py-pip make automake gcc g++ subversion
RUN pip install pandas urllib3==1.24.3 PyYAML==3.13 ipython
#RUN pip install -U sagemaker-python-sdk