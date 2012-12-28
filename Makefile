all: about.html index.html code.html photography.html

about.html : about.htm header.htm footer.htm
	cat header.htm about.htm footer.htm > about.html

index.html : index.htm header.htm footer.htm
	cat header.htm index.htm footer.htm > index.html

code.html : code.htm header.htm footer.htm
	cat header.htm code.htm footer.htm > code.html

photography.html : photography.htm header.htm footer.htm
	cat header.htm photography.htm footer.htm > photography.html

clean : 
	rm -f *.html



