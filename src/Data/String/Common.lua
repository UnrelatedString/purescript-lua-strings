return {
  _localeCompare = (function(lt)
    return function(eq)
      return function(gt)
        return function(s1) return function(s2) return (s1 < s2) and lt or (s2 < s1) and gt or eq end end
      end
    end
  end),
  replace = (function(pattern)
    return function(replacement) return function(string) return string:gsub(pattern, replacement, 1) end end
  end),
  replaceAll = (function(pattern)
    return function(replacement) return function(string) return string:gsub(pattern, replacement) end end
  end),
  findSubstringFrom = (function(pattern, in, from, just, nothing)
    local start = string.find(in, pattern, from, true)
    if start == nil then
      return nothing
    else
      return just(start)
    end
  end),
  grabSubstringIGuess = (function(s, i, j)
    return string.sub(s, i, j)
  end),
  toLower = (function(s) return s:lower() end),
  toUpper = (function(s) return s:upper() end),
  trim = (function(s) return s:match("^%s*(.-)%s*$") end),
  joinWith = (function(sep) return function(xs) return table.concat(xs, sep) end end)
}
