defmodule Bob do
  @cyrilic ~r/^.\p{Cyrillic}.*$/u
  @only_numbers ~r{^[0-9,\s]*$}
  @question ~r{\?[\s]*$}
  @say_nothing ~r{^\s*$}
  @shouting ~r{^([A-Z0-9,\s!($#@*^%])*$}
  @something_else true
  @yell_question ~r{^([A-Z\s'!])*\?$}

  def hey(input) do
    cond do
      is_saying_nothing(input) -> "Fine. Be that way!"
      is_shouting(input) -> "Whoa, chill out!"
      is_asking_yelling(input) -> "Calm down, I know what I'm doing!"
      is_asking(input) -> "Sure."
      @something_else -> "Whatever."
    end
  end

  defp is_asking(input), do: Regex.match?(@question, input)
  defp is_asking_yelling(input), do: Regex.match?(@yell_question, input)
  defp is_saying_nothing(input), do: Regex.match?(@say_nothing, input)

  defp is_shouting(input) do
    (Regex.match?(@shouting, input) or Regex.match?(@cyrilic, input)) and
      not Regex.match?(@only_numbers, input)
  end
end
