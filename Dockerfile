FROM lamtev/cxx:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:beineri/opt-qt593-xenial


RUN rm -rf /var/lib/update-notifier/package-data-downloads/partial/* \
	&& apt-get update && echo y | apt-get dist-upgrade && apt-get install -y \
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
		libfuse2 \
	&& rm -rf /var/lib/apt/lists/* \
	&& cd /tmp \
  	&& apt-get download fuse \
  	&& dpkg-deb -x fuse_* . \
  	&& dpkg-deb -e fuse_* \
  	&& rm fuse_*.deb \
  	&& echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst \
  	&& dpkg-deb -b . /fuse.deb \
	&& dpkg -i /fuse.deb

ENV PATH /opt/qt59/bin:$PATH

# Fake a fuse install
# from https://gist.github.com/henrik-muehe/6155333/e35981031bad80ada4cbf1e4a48ba7f86a019db4
# see https://github.com/dotcloud/docker/issues/2191
#RUN apt-get install libfuse2
#RUN cd /tmp &&\
#  	apt-get download fuse &&\
#  	dpkg-deb -x fuse_* . &&\
#  	dpkg-deb -e fuse_* &&\
#  	rm fuse_*.deb &&\
#  	echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst &&\
#  	dpkg-deb -b . /fuse.deb &&\
#	dpkg -i /fuse.deb

