FROM lamtev/cxx:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:beineri/opt-qt593-xenial


RUN apt-get update && echo y | apt-get dist-upgrade && apt-get install -y \
		dialog apt-utils \
		libgl1-mesa-dev \
		libgl1-mesa-glx \
		qt59-meta-full \
		qt59base \
		qt59declarative \
		qt59tools \
		qt59translations \
		qt59declarative \
		qt59svg \
		qt59script \
		qt59quickcontrols \
		qt59quickcontrols2 \
	&& rm -rf /var/lib/apt/lists/*

# Fake a fuse install
RUN apt-get install libfuse2 -y
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb

ENV PATH /opt/qt59/bin:$PATH
