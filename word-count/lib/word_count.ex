defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @word_delimiter ~r/[^[:alnum:]\-]/u

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> split_words
    |> count_frequencies_downcasing
  end

  defp split_words(sentence), do: String.split(sentence, @word_delimiter, trim: true)

  defp count_frequencies_downcasing(words), do: Enum.frequencies_by(words, &String.downcase/1)
end
