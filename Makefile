DOCKER := $(shell command -v docker 2> /dev/null)

.PHONY:
all: spie-10707-10.pdf

ifndef DOCKER
spie-10707-10.pdf: *.tex
	latexmk -pdf -bibtex spie-10707-10
else
.PHONY: spie-2018
spie-2018:
	(cd docker; make)

spie-10707-10.pdf: *.tex spie-2018
	docker run --rm \
		-v `pwd`:/build -w /build \
		-u $(shell id -u):$(shell id -g) \
		spie-2018:latest sh -c 'make'
endif
