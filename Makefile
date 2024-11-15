
.PHONY : all html pdf slides answers ingest clean

all : html pdf slides answers docs/r-intro.zip 

html :
	cd book ; quarto render --to html

pdf :
	cd book ; quarto render --to pdf
	
slides :
	cd slides ; quarto render

answers :
	cd answers ; quarto render

docs/r-intro.zip : r-intro/*
	zip -FSr docs/r-intro.zip r-intro

ingest :
	cd ingest ; make

clean :
	rm -rf docs/*
