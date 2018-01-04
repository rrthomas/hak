local std = require "std".barrel()

local hakvm = require "hakvm"

local code, cell

-- An atom
code = {atom = "hello"}
cell = hakvm.Cell (code)
print (cell)
--print (hakvm.evaluate (cell))

-- An atom with empty children
code = {atom = 1, children = {}}
cell = hakvm.Cell (code)
print (cell)
--print (hakvm.evaluate (cell))

-- An atom with some children
code = {
  atom = "hello",
  children = {{atom = 1, children = {"x", "y"}}, 2, 3},
}
cell = hakvm.Cell (code)
print (cell)
--print (hakvm.evaluate (cell))

-- Children with no atom
code = {
  children = {{atom = "hello"}}
}
cell = hakvm.Cell (code, {})
print (cell)
--print (hakvm.evaluate (cell))

-- An instruction
code = {}
code.atom = "Get"
code.children = {{parent = code, index = 2}}
