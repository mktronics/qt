FROM lamtev/cxx:latest

RUN apt-get update && apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:beineri/opt-qt594-xenial


RUN rm -rf /var/lib/update-notifier/package-data-downloads/partial/* \
	&& apt-get update && echo y | apt-get dist-upgrade && apt-get install -y \
		dialog apt-utils \
		libgl1-mesa-dev \
		libgl1-mesa-glx \
		qt59base \
		qt59declarative \
		qt59tools \
		qt59quickcontrols2 \
		qt59multimedia \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /opt/qt59/bin:$PATH
