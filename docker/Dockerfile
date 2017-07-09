FROM cyberdojofoundation/gplusplus:7.1
MAINTAINER Jon Jagger <jon@jaggersoft.com>

RUN apt-get update && apt-get -y install wget cmake unzip

RUN wget https://github.com/cgreen-devs/cgreen/archive/master.zip \
  && unzip master.zip \
  && rm master.zip \
  && cd cgreen-master \
  && mkdir build \
  && cd build \
  && cmake -DCGREEN_WITH_CXX:bool=ON .. \
  && make \
  && make install

COPY red_amber_green.rb /usr/local/bin
