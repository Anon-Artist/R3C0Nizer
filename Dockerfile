FROM ubuntu
LABEL version="1.0"
LABEL project="R3CONIZER"
LABEL maintainer="Anon-Artist"
LABEL author="DanBrown47"
RUN apt-get update
RUN mkdir -p /recon
WORKDIR /recon
COPY . .
RUN apt-get install -y wget python2 python-setuptools  python3 python3-pip 
RUN wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz && export PATH=$PATH:/usr/local/go/bin &&  go version
RUN chmod +x reconizer.sh 
RUN echo "export PATH=$PATH:~/go/bin" |  tee -a ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
ENTRYPOINT ["/bin/bash", "/recon/reconizer.sh"]

