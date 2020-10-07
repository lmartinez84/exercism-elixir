defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @not_interesting_chars ~r/[\s\-]/

  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    new_sentence = sentence |> strip_not_interesing_chars()

    new_sentence
    |> number_of_unique_letters()
    |> sentence_has_only_unique_letters?(new_sentence)
  end

  defp strip_not_interesing_chars(sentence),
    do: String.replace(sentence, @not_interesting_chars, "")

  defp sentence_has_only_unique_letters?(freqs, sentence), do: freqs == String.length(sentence)

  defp number_of_unique_letters(letters) do
    letters
    |> String.to_charlist()
    |> Enum.frequencies()
    |> count_unique_letters()
  end

  defp count_unique_letters(freqs) do
    Map.keys(freqs) |> Enum.count()
  end
end
