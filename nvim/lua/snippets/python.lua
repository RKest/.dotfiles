--- @diagnostic disable: undefined-global

return {
  s(
    { trig = "(.*)pv", regTrig = true },
    fmta(
      [[
				print(F"{<>=}")
      ]],
      { f(function (_, s) return s.captures[1] end) }
    )
  ),
}
