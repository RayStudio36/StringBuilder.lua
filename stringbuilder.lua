---
--- StringBuilder v0.2 by yangruihan
--- See https://github.com/RayStudio36/StringBuilder.lua for usage documentation.
--- Licensed under MIT.
--- See https://opensource.org/licenses/MIT for details.
---

---@class StringBuilder
local StringBuilder = {}

StringBuilder.__index = StringBuilder

setmetatable(
    StringBuilder,
    {
        __call = function(class, ...)
            local instance = {}
            setmetatable(instance, StringBuilder)
            instance:new(...)
            return instance
        end
    }
)

function StringBuilder:new()
    self._buffer = {}
end

function StringBuilder:append(...)
    for i = 1, select("#", ...) do
        table.insert(self._buffer, tostring(select(i, ...)))
    end
    return self
end

---@param format string
function StringBuilder:append_format(format, ...)
    table.insert(self._buffer, format:format(...))
end

function StringBuilder:append_line(...)
    local len = select("#", ...)
    if len > 0 then
        for i = 1, len do
            table.insert(self._buffer, tostring(select(i, ...)))
            table.insert(self._buffer, "\n")
        end
    else
        table.insert(self._buffer, "\n")
    end
    return self
end

---@param array table
---@param seperator string
function StringBuilder:append_array(array, seperator)
    if not array then
        return self
    end

    seperator = seperator or ", "
    for i, v in ipairs(array) do
        if i == #array then
            table.insert(self._buffer, string.format("%d: %s", i, tostring(v)))
        else
            table.insert(self._buffer, string.format("%d: %s%s", i, tostring(v), seperator))
        end
    end
    return self
end

---@param t table
---@param seperator string
function StringBuilder:append_table(t, seperator)
    if not t then
        return self
    end

    local cnt = 0
    seperator = seperator or ", "
    for k, v in pairs(t) do
        cnt = cnt + 1
        table.insert(self._buffer, string.format("{%s: %s}%s", tostring(k), tostring(v), seperator))
    end

    if cnt > 0 then
        local last_str = self._buffer[#self._buffer]
        self._buffer[#self._buffer] = last_str:sub(1, #last_str - #seperator)
    end

    return self
end

---@param clear boolean will clear buffer, default false
function StringBuilder:tostring(clear)
    clear = clear or false
    local ret = table.concat(self._buffer)
    if clear then
        self:clear()
    end
    return ret
end

function StringBuilder:clear()
    self._buffer = {}
end

return StringBuilder
