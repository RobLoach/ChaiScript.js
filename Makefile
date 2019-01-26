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

#-s EXPORT_NAME='chaiscript' \

OPTIMIZATION := -O0

all: native wasm html

dist: vendor/ChaiScript/readme.md
	mkdir -p dist

dist/wasm: dist
	mkdir -p dist/wasm

dist/html: dist
	mkdir -p dist/html

vendor/ChaiScript/readme.md:
	git submodule update --init

native: dist
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s WASM=0 -s SINGLE_FILE=1 -o dist/chaiscript.js

wasm: dist/wasm
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s WASM=1 -s SINGLE_FILE=1 -o dist/wasm/chaiscript.js

html: dist/html
	em++ $(SOURCES) $(DEFINES) $(OPTIMIZATION) -s SINGLE_FILE=1 --shell-file src/chaiscript.html -s WASM=0 -o dist/html/index.html
	cp node_modules/milligram/dist/milligram.min.css node_modules/milligram/dist/milligram.min.css.map dist/html

build:
	$(MAKE) OPTIMIZATION=-O2 all

# TODO: Add wasm test
test: native wasm html
	npm t

clean:
	rm -rf dist