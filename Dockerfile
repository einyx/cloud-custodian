FROM python:3.7

LABEL name="custodian" \
  version="" \
  description="Cloud Management Rules Engine"

ADD ./ /src/


# Install Custodian Core & AWS
WORKDIR /src
RUN pip3 install -r requirements.txt -e .

EXPOSE 0
HEALTHCHECK NONE
# Setup for EntryPoint
ENV LC_ALL="C.UTF-8" LANG="C.UTF-8"
VOLUME ["/var/log/cloud-custodian", "/etc/cloud-custodian"]
ENTRYPOINT ["/usr/local/bin/custodian"]
CMD ["bash"]
