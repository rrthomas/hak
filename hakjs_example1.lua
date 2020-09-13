local std = require "std".barrel()

local hakvm = require "hakvm"

local code, cell

-- An atom
cell = hakvm.Cell ({atom = "hello"})
print (cell)
--print (hakvm.evaluate (cell))

-- An atom with empty children
cell = hakvm.Cell ({atom = 1, children = {}})
print (cell)
--print (hakvm.evaluate (cell))

-- An atom with some children
cell = hakvm.Cell ({
  atom = "hello",
  children = {{atom = 1, children = {"x", "y"}}, 2, 3},
})
print (cell)
--print (hakvm.evaluate (cell))

-- Children with no atom
cell = hakvm.Cell ({
  children = {{atom = "hello"}}
})
print (cell)
--print (hakvm.evaluate (cell))

-- An instruction
code = {}
code.atom = "Get"
code.children = {{parent = code, index = 2}}
