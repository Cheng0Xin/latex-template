FILENAME=template
build:
	latexmk -jobname='${FILENAME}' --shell-escape -quiet

debug:
	latexmk -jobname='${FILENAME}' --shell-escape

clean:
	latexmk -C -jobname='${FILENAME}'
	rm *.bbl
	rm *.run.xml
