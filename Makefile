build:
	latexmk

buildcode:
	make -f code/Makefile

clean:
	latexmk -C
