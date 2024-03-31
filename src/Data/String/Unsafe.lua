return {
  charAt = (function(i)
    return function(s)
      if i >= 0 and i < #s then return s:sub(i + 1, i + 1) end
      error("Data.String.Unsafe.charAt: Invalid index.")
    end
  end),
  char = (function(s)
    if #s == 1 then return s end
    error("Data.String.Unsafe.char: Expected string of length 1.")
  end)
}
