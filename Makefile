all: 
	elm make Main.elm

clean:
	$(RM) index.html
	$(RM) elm.js

serve: clean all
	-elm reactor -p8888
