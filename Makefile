
.PHONY : all pdf html ingest clean

all : pdf html docs/r-intro-2-files.zip

pdf :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::pdf_book')"

html :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::gitbook')"
	cp -r figures docs/figures

docs/r-intro-2-files.zip : r-intro-2-files/*
	zip -FSr docs/r-intro-2-files.zip r-intro-2-files

ingest :
	cd ingest ; make

clean :
	rm -rf docs/*
