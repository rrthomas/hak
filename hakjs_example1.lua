std = require "std".barrel()

hakvm = require "hakvm"

local Root = {}

local code

-- An atom
code = {atom = "hello"}
cell = hakvm.Cell (code, {children = code})
print (cell)
print (hakvm.evaluate (cell))

-- An atom with some children
code = {
  atom = "hello",
  children = {{atom = 1, children = {}}, 2, 3},
}
cell = hakvm.Cell (code, {children = code})
print (cell)
print (hakvm.evaluate (cell))
