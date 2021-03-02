
ANSWER_HTMLS=docs/answers-reading-r-code.html

.PHONY : all pdf html ingest clean

all : $(ANSWER_HTMLS) pdf html docs/r-intro-2-files.zip 

pdf :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::pdf_book')"

html :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::gitbook')"
	cp -R book/figures docs

docs/r-intro-2-files.zip : r-intro-2-files/*
	zip -FSr docs/r-intro-2-files.zip r-intro-2-files

docs/%.html : answers/%.Rmd
	Rscript -e "rmarkdown::render('$<', output_file='../$@')"

ingest :
	cd ingest ; make

clean :
	rm -rf docs/*
