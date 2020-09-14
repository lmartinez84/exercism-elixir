defmodule MatchingBrackets do
  defguard is_not_in_brackets(char) when char not in [?], ?}, ?[, ?{, ?), ?(]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    match_bracket?(String.to_charlist(str), [])
  end

  @spec match_bracket?(list :: list, acc :: list) :: boolean
  defp match_bracket?([first | list], acc) when is_not_in_brackets(first),
    do: match_bracket?(list, acc)

  defp match_bracket?([?] | list], [?[ | acc]), do: match_bracket?(list, acc)
  defp match_bracket?([?) | list], [?( | acc]), do: match_bracket?(list, acc)
  defp match_bracket?([?} | list], [?{ | acc]), do: match_bracket?(list, acc)
  defp match_bracket?([first | list], acc), do: match_bracket?(list, [first | acc])
  defp match_bracket?([], []), do: true
  defp match_bracket?([], _acc), do: false
end
