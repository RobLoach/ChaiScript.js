#include <string>
#include <chaiscript/chaiscript.hpp>
#include <emscripten/bind.h>
#include <emscripten.h>

using namespace emscripten;
using namespace chaiscript;

void ChaiScriptEval(ChaiScript& chai, const std::string& input) {
	chai.eval(input);
}

template <class ReturnType>
ReturnType ChaiScriptEvalReturn(ChaiScript& chai, const std::string& input) {
	return chai.eval<ReturnType>(input);
}

EMSCRIPTEN_BINDINGS(chaiscript) {
	class_<ChaiScript>("ChaiScript")
		.constructor<>()
		.function("eval", &ChaiScriptEval)
		.function("evalString", &ChaiScriptEvalReturn<std::string>)
		.function("evalBool", &ChaiScriptEvalReturn<bool>)
		.function("evalInt", &ChaiScriptEvalReturn<int>)
		.function("evalFloat", &ChaiScriptEvalReturn<float>)
		.function("evalDouble", &ChaiScriptEvalReturn<double>)
	;
}
