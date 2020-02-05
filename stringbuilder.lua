---
--- StringBuilder v0.1 by yangruihan
--- See https://github.com/RayStudio36/StringBuilder.lua for usage documentation.
--- Licensed under MIT.
--- See https://opensource.org/licenses/MIT for details.
---


local StringBuilder = {}

StringBuilder.__index = StringBuilder

setmetatable(StringBuilder, {
    __call = function (class, ...)
        local instance = {}
        setmetatable(instance, StringBuilder)
        instance:new(...)
        return instance
    end
})


function StringBuilder:new()
    self.buffer = {}
end


function StringBuilder:append(...)
    local args = {...}
    for i = 1, #args do
        table.insert(self.buffer, args[i])
    end
    return self
end


function StringBuilder:append_line(...)
    local args = {...}
    for i = 1, #args do
        table.insert(self.buffer, args[i])
        table.insert(self.buffer, '\n')
    end
    table.insert(self.buffer, '\n')
    return self
end


function StringBuilder:append_array(array, seperator)
    if not array then return self end

    seperator = seperator or ', '
    for i, v in ipairs(array) do
        if i == #array then
            table.insert(self.buffer, string.format('%d: %s', i, tostring(v)))
        else
            table.insert(self.buffer,
                         string.format('%d: %s%s', i, tostring(v), seperator))
        end
    end
    return self
end


function StringBuilder:append_table(t, seperator)
    if not t then return self end

    local cnt = 0
    seperator = seperator or ', '
    for k, v in pairs(t) do
        cnt = cnt + 1
        table.insert(self.buffer,
                     string.format('{%s: %s}%s',
                                   tostring(k),
                                   tostring(v), seperator))
    end

    if cnt > 0 then
        local last_str = self.buffer[#self.buffer]
        self.buffer[#self.buffer] =  last_str:sub(1, #last_str - #seperator)
    end

    return self
end


function StringBuilder:tostring(clear)
    clear = clear or false
    local ret = table.concat(self.buffer)
    if clear then self:clear() end
    return ret
end


function StringBuilder:clear()
    self.buffer = {}
end


return StringBuilder