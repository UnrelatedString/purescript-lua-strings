return {
  fromCharArray = (function(a) return table.concat(a) end),
  toCharArray = (function(s)
    local t = {}
    for i = 1, #s do t[i] = s:sub(i, i) end
    return t
  end),
  singleton = (function(c) return c end),
  _charAt = (function(just)
    return function(nothing)
      return function(i)
        return function(s)
          if i >= 1 and i <= #s then
            return just(s:sub(i, i))
          else
            return nothing
          end
        end
      end
    end
  end),
  _toChar = (function(just)
    return function(nothing)
      return function(s)
        if #s == 1 then
          return just(s)
        else
          return nothing
        end
      end
    end
  end),
  length = (function(s) return #s end),
  countPrefix = (function(p)
    return function(s)
      local i = 1
      while i <= #s and p(s:sub(i, i)) do i = i + 1 end
      return i - 1
    end
  end),
  _indexOf = (function(just)
    return function(nothing)
      return function(x)
        return function(s)
          local i = s:find(x, 1, true)
          if i then
            return just(i)
          else
            return nothing
          end
        end
      end
    end
  end),
  _indexOfStartingAt = (function(just)
    return function(nothing)
      return function(x)
        return function(startAt)
          return function(s)
            local i = s:find(x, startAt, true)
            if i then
              return just(i)
            else
              return nothing
            end
          end
        end
      end
    end
  end),
  _lastIndexOf = (function(just)
    return function(nothing)
      return function(x)
        return function(s)
          local i = s:reverse():find(x:reverse(), 1, true)
          if i then
            return just(#s - i + 1)
          else
            return nothing
          end
        end
      end
    end
  end),
  _lastIndexOfStartingAt = (function(just)
    return function(nothing)
      return function(x)
        return function(startAt)
          return function(s)
            local i = s:reverse():find(x:reverse(), #s - startAt + 1, true)
            if i then
              return just(#s - i + 1)
            else
              return nothing
            end
          end
        end
      end
    end
  end),
  take = (function(n) return function(s) return s:sub(1, n) end end),
  drop = (function(n) return function(s) return s:sub(n + 1) end end),
  slice = (function(b) return function(e) return function(s) return s:sub(b + 1, e) end end end),
  splitAt = (function(i) return function(s) return {before = s:sub(1, i), after = s:sub(i + 1)} end end)
}
