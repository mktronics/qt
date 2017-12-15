FROM lamtev/cxx:latest

RUN apt-get update && apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:beineri/opt-qt593-xenial

RUN apt-get update && apt-get install -y \
		libgl1-mesa-dev \
		qt59base \
		qt59declarative \
		qt59tools \
		qt59translations \
		qt59quickcontrols2\
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /opt/qt5/bin:$PATH
