build: elm-instrumented.js

elm.js: Main.elm
	elm make Main.elm --output elm.js

elm-instrumented.js: elm.js
	awk '/inputs = rootNode.kids;/ { print; print "printGraph(inputs);"; next; }1' $< > $@

