# ChaiScript.js

JavaScript port of [ChaiScript](http://chaiscript.com), an easy to use embedded scripting language, powered through Emscripten.

## Node.js

``` bash
npm init
npm install chaiscript --save
```

``` javascript
// Load the ChaiScript module.
const chaiscript = require('chaiscript')

// Create the Chai instance.
const chai = new chaiscript.ChaiScript()

// Get some code to use.
const code = `
	def hello(name) {
		return "Hello " + name
	}

	var output = hello("Bob")
	print(output)
`

// Run the code through the ChaiScript instance.
chai.eval(code)

// Make sure to clean up when you're done.
chai.delete()
```

## API

### `new chaiscript.ChaiScript()`

Create a new ChaiScript environment

### `.eval(string)`

Executes the given code.

### `.evalString(string)`

Executes the given code, and returns the output as a string.
