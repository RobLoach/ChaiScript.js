const assert = require('assert')
const chaiscript = require('..');

describe('chaiscript', function() {
  describe('.ChaiScript()', function() {
  	var chai = null

  	beforeEach(function() {
  		chai = new chaiscript.ChaiScript()
  	})

  	afterEach(function () {
  		chai.delete()
  	})

    it('.eval()', function() {
		const code = `
			def hello(name) {
				return "      Hello, from " + name
			}

			var output = hello("ChaiScript")
			print(output)
		`
		chai.eval(code)
    })

    it('.evalString()', function() {
		const code = `
			def greetings(name) {
				return "Greetings, " + name
			}
			return greetings("World")
		`
		const output = chai.evalString(code)
		assert.equal(output, "Greetings, World")
    })

    it('.evalInt()', function() {
		assert.equal(chai.evalInt('4 + 5'), 9)
    })

    it('.evalDouble()', function() {
		assert.equal(chai.evalDouble('4.5 + 5.8'), 10.3)
    })

  })
})
