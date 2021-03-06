#!/usr/bin/env lua
-- Array Machine (Hak VM)
-- Reuben Thomas 31/12/17-4/1/18

-- Cell representation: {atom, children (array of cells), parent}
-- Location representation: {parent, index}
-- Extra Root node is added to make data instructions easier to implement

-- Code representation
local Nil = {} -- distinguished value

-- Instructions
local Instructions -- declaration for evaluate

-- Evaluate a node
local function evaluate (i)
  if i.atom == Nil or not Instructions[i.atom] then
    return i
  end
  return Instructions[i.atom](i)
end

-- Execution loop
local function execute (pp)
  while pp ~= nil and pp ~= Nil do
    pp = evaluate (pp)
  end
end

local function Instruction (code)
  return function (inst)
    local arg = {}
    for i = 1, #inst.children do
      arg.insert (evaluate (inst.children (i)))
    end
    local ret, pp = code (table.unpack (arg))
    if pp == nil then
      pp = Instructions.Next (pp)
    end
    return ret, pp
  end
end

local Actions -- Allow actions to reference each other
Actions = {
  ["nil"] = function () return Nil end, -- distinguished value

  -- Data
  parent = function (loc)
    if loc.parent.parent == nil then -- Return Nil for root node
      return Nil
    else
      return loc.parent
    end
  end,

  -- FIXME: currently this does not return a location; if the children list is empty, how to discriminate between empty list and Nil?
  -- Could have location with index = Nil, but this is not Set-able
  -- Could have Nil? and Empty? predicates, only allow Setting of non-Empty location
  -- Or have different types of location: array and cell; Parent and Children return array, can apply Empty? to it; Start/End take array and return cell (if poss); other location instructions take/return cell; add Array instruction that returns array of a cell
  children = function (loc) return loc.parent.children end,

  previous = function (loc)
    if loc.index > 0 then
      return {parent = loc.parent, index = loc.index - 1}
    end
    return Nil
  end,

  next = function (loc)
    if loc.index < #loc.parent.children then
      return {parent = loc.parent, index = loc.index + 1}
    end
    return Nil
  end,

  start = function (loc) return {parent = loc.parent, index = 1} end,
  ["end"] = function (loc) return {parent = loc.parent, index = #loc.parent.children} end,

  get = function (loc) return loc.parent.children[loc.index] end,

  set = function (loc, val)
    loc.parent.children[loc.index] = val
    return val
  end,

  -- FIXME: Document this instruction
  grow = function (loc)
    if not loc.parent.children or loc.parent.children == Nil then
      loc.parent.children = {}
    end
    return loc
  end,

  -- FIXME: Document this instruction
  prune = function (loc)
    loc.children = Nil
    return loc
  end,

  insertBefore = function (loc)
    table.insert (loc.parent.children, loc.index, Nil)
    return {parent = loc.parent, index = 1}
  end,

  insertAfter = function (loc)
    table.insert (loc.parent.children, Nil)
    return {parent = loc.parent, index = #loc.parent.children}
  end,

  remove = function (loc)
    table.remove (loc.parent.children, loc.index)
    return Nil
  end,

  -- Control
  ["if"] = function (atom_0, cell_e, ...)
    local arg = {...}
    for i = 1, #arg do
      if atom_0 == i.atom then
        return evaluate (i.children)
      end
    end
    return cell_e
  end,

  jump = function (target, val)
    if target.atom == "Save" then
      local loc = evaluate (target.children[0])
      loc.children = val
      return val, Actions.next (target)
    end
    return Nil
  end,

  save = function () return Nil end, -- Does nothing when not reached from a Jump
}

Instructions = {}
for name, fn in pairs (Actions) do
  local iname = string.upper (name:sub (1, 1)) .. name:sub (2)
  Instructions[iname] = Instruction (fn)
end

-- Convert {atom = ATOM, children = LIST}/atom to cell representation
-- FIXME: use instructions to construct the cell representation
local function Cell (val)
  local function mkCell (val, parent)
    local cell = {parent = parent}
    local ty = type (val)
    if ty == "table" then -- assume cell
      cell.atom = val.atom
      if val.children then
        cell.children = {}
        for _, v in ipairs (val.children) do
          table.insert (cell.children, Cell (v, cell))
        end
      end
    else -- assume atom
      cell.atom = val
    end
    return cell
  end
  local root = {}
  root.children = mkCell (val, root)
  return root
end

return {
  evaluate = evaluate, -- TODO: Remove this, export only execute?
  execute = execute,
  Cell = Cell,
}
