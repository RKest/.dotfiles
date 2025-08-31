--- @diagnostic disable: undefined-global

return {
  s(
    { trig = "iferr", snippetType = "autosnippet" },
    fmta(
      [[
        if err != nil {
        	return fmt.Errorf("<>%w", err)
        }
      ]],
      { i(1) }
    )
  ),
}
