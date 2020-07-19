require("test.luaunit")

local StringBuilder = require("stringbuilder")

TestStringBuilder = {}

function TestStringBuilder:test_new()
    local sb = StringBuilder()
    assertNotNil(sb)
    assertEquals(#sb._buffer, 0)
end

function TestStringBuilder:test_append()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append(1)
    assertEquals(sb:tostring(), "1")

    sb:append("2")
    assertEquals(sb:tostring(), "12")

    sb:append(false)
    assertEquals(sb:tostring(), "12false")

    sb:append(1.4)
    assertEquals(sb:tostring(), "12false1.4")

    sb:append(nil)
    assertEquals(sb:tostring(), "12false1.4nil")
end

function TestStringBuilder:test_append2()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append(1, 1.4, "2", false, nil)
    assertEquals(sb:tostring(), "11.42falsenil")
end

function TestStringBuilder:test_append_format()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_format("%d%.1f%s", 1, 1.4, "hello")
    assertEquals(sb:tostring(), "11.4hello")
end

function TestStringBuilder:test_append_line()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_line()
    assertEquals(sb:tostring(), "\n")

    sb:append_line(1, 1.4, "2", false, nil)
    assertEquals(sb:tostring(), "\n1\n1.4\n2\nfalse\nnil\n")
end

function TestStringBuilder:test_append_array()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_array({1, 2, 3})
    assertEquals(sb:tostring(), "1: 1, 2: 2, 3: 3")
end

function TestStringBuilder:test_append_array2()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_array({1, 2, 3}, " | ")
    assertEquals(sb:tostring(), "1: 1 | 2: 2 | 3: 3")
end

function TestStringBuilder:test_append_table()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_table({a = 1, b = 2})
    local ret = sb:tostring()
    assertTrue(ret == "{a: 1}, {b: 2}" or ret == "{b: 2}, {a: 1}")
end

function TestStringBuilder:test_append_table2()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append_table({a = 1, b = 2}, " | ")
    local ret = sb:tostring()
    assertTrue(ret == "{a: 1} | {b: 2}" or ret == "{b: 2} | {a: 1}")
end

function TestStringBuilder:test_clear()
    local sb = StringBuilder()
    assertNotNil(sb)

    sb:append(1, 1.4, "2", false, nil)
    assertEquals(sb:tostring(), "11.42falsenil")
    assertTrue(#sb._buffer > 0)

    sb:clear()
    assertEquals(sb:tostring(), "")
    assertTrue(#sb._buffer == 0)
end

lu = LuaUnit.new()
lu:setOutputType("tap")
os.exit(lu:runSuite())
