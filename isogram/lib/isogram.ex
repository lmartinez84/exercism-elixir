defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
      sentence
      |> String.to_charlist()
      |> Enum.frequencies()
      |> count_frequencies
      |> equal?(sentence)
  end

  defp equal?(freqs, sentence) do
      freqs == String.length(sentence)
  end

  defp count_frequencies(freqs) do
    count_uniq(freqs) + count_char(freqs, ?-) + count_char(freqs, ?\s)
  end

  defp count_char(freqs, char) do
    case Map.get(freqs, char, 0) do
      0 -> 0
      n -> n - 1
    end
  end

  defp count_uniq(freqs) do
    Map.keys(freqs) |> Enum.count()
  end
end
