# StringBuilder v0.2

StringBuilder module for lua

## Installation

The stringbuilder.lua file should be dropped into an existing project and required by it.

```lua
StringBuilder = require 'stringbuilder'
```

## Example

```lua
sb = StringBuilder()
sb:append(1):append('hello'):append(true)
sb:append(1, 2, 3)
sb:append_format('%d%s', 1, 'hello')
sb:append_line(1, 2, 3)
sb:append_array({1, 2, 3}, ', ')
sb:append_table({a=1, b=2, c=3}, ', ')
str = sb:tostring()
sb:clear()
```
