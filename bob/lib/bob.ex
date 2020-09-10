defmodule Bob do
  @something_else true

  def hey(input) do
    cond do
      asking_yelling?(input) -> "Calm down, I know what I'm doing!"
      asking?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      saying_nothing?(input) -> "Fine. Be that way!"
      @something_else -> "Whatever."
    end
  end

  defp asking?(input), do: ends_with_question_mark?(input)
  defp asking_yelling?(input), do: yelling?(input) and ends_with_question_mark?(input)
  defp yelling?(input), do: input == String.upcase(input) and input != String.downcase(input)
  defp ends_with_question_mark?(input), do: String.trim(input) |> String.ends_with?("?")
  defp saying_nothing?(input), do: String.trim(input) |> String.length() == 0
end
