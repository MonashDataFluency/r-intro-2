
all : pdf html

pdf :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::pdf_book')"

html :
	cd book ; Rscript -e "bookdown::render_book('.', 'bookdown::gitbook')"


ingest :
	cd ingest ; make

