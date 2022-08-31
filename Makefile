FILENAME=template
build:
	latexmk -jobname='${FILENAME}' --shell-escape -quiet

clean:
	latexmk -C -jobname='${FILENAME}'
	rm *.bbl
	rm *.run.xml
