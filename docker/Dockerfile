FROM cyberdojofoundation/gplusplus
LABEL maintainer=jon@jaggersoft.com

RUN \
apt-get update && \
apt-get install --yes \
   cmake \
   git && \
\
git clone https://github.com/cgreen-devs/cgreen.git && \
\
cd cgreen && \
cmake . && \
make && \
make install && \
cd .. && \
rm -rf cgreen && \
\
apt-get remove --yes cmake git

COPY red_amber_green.rb /usr/local/bin
