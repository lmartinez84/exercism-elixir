defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    freq = count_frequencies(base)

    for x <- candidates, check_match(base, freq, x), do: x
  end

  @spec count_frequencies(String.t()) :: Map.t()
  defp count_frequencies(base) do
    base
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.frequencies()
  end

  @spec check_match(String.t(), Map.t(), String.t()) :: boolean()
  defp check_match(base, freq, x) do
    base = String.downcase(base)
    x = String.downcase(x)

    case are_equal?(base, x) do
      :equal -> :false
      :different -> is_anagram?(freq, x)
    end
  end

  @spec are_equal?(base :: String.t(), x :: String.t()) :: atom()
  defp are_equal?(base, x) do
    case base === x do
      :true -> :equal
      :false -> :different
    end
  end

  @spec is_anagram?(freq :: Map.t(), x :: String.t()) :: boolean()
  defp is_anagram?(freq, x) do
    res =
      x
      |> String.to_charlist()
      |> Enum.frequencies()

    res === freq
  end
end
