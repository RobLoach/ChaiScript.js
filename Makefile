SOURCES = src/chaiscript.cpp
DEFINES = -std=c++1z \
	-I vendor/ChaiScript/include \
	-s NO_EXIT_RUNTIME=0 \
	-DCHAISCRIPT_NO_DYNLOAD \
	-DCHAISCRIPT_NO_THREADS \
	-DCHAISCRIPT_NO_THREADS_WARNING \
	-s DEMANGLE_SUPPORT=1 \
	-s DISABLE_EXCEPTION_CATCHING=0 \
	--bind

OPTIMIZATION := -O0

all: dist/chaiscript.js dist/wasm/chaiscript.js dist/html/index.html

dist: vendor/ChaiScript/readme.md
	mkdir -p dist

dist/wasm: dist
	mkdir -p dist/wasm

dist/html: dist
	mkdir -p dist/html

vendor/ChaiScript/readme.md:
	git submodule update --init

dist/chaiscript.js: dist
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s WASM=0 -s SINGLE_FILE=1 -o dist/chaiscript.js

dist/wasm/chaiscript.js: dist/wasm
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s WASM=1 -s SINGLE_FILE=1 -o dist/wasm/chaiscript.js

dist/html/index.html: dist/html
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s SINGLE_FILE=1 --shell-file src/chaiscript.html -s WASM=0 -o dist/html/index.html
	cp node_modules/milligram/dist/milligram.min.css node_modules/milligram/dist/milligram.min.css.map src/logo.png dist/html

build:
	$(MAKE) OPTIMIZATION=-O2 all

test: dist/chaiscript.js
	npm t

clean:
	rm -rf dist