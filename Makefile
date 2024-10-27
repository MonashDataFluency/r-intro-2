
.PHONY : all pdf html answers ingest clean

all : html pdf answers docs/r-intro.zip 

html :
	cd book ; quarto render --to html

pdf :
	cd book ; quarto render --to pdf

answers :
	cd answers ; quarto render

docs/r-intro.zip : r-intro/*
	zip -FSr docs/r-intro.zip r-intro

ingest :
	cd ingest ; make

clean :
	rm -rf docs/*
