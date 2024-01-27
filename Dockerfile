FROM photon:4.0-20230506

RUN tdnf install -y xfsprogs e2fsprogs udev && \
    tdnf clean all

WORKDIR /opt/t1cloud/bin

COPY LICENSE.txt .
COPY bin/t1cloud-k8s-csi .

RUN chmod +x /opt/t1cloud/bin/t1cloud-k8s-csi

# USER nobody
ENTRYPOINT ["./t1cloud-k8s-csi"]
