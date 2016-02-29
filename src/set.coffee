{call, read, isObject, isArray} = require "fairmont"
YAML = require "js-yaml"
{get, set} = require "./reference"

[path, reference, value] = process.argv[2..]

if path? && reference? && value?
  call ->
    root = current = YAML.safeLoad yield read path
    [keys..., last] = reference.split "."
    for key in keys
      current = get current, key
    set current, last, value
    result = YAML.safeDump root
    console.log result
else
  console.error "yaml set: insufficient arguments"
  console.error "yaml set <path> <reference> <value>"
  process.exit -1