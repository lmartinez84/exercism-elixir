defmodule PigLatin do
  @vowels MapSet.new(["a", "e", "i", "o", "u"])
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    cond do
      MapSet.member?(@vowels, String.first(phrase)) === :true ->  phrase <> "ay"
      true ->  with_consonants_preffix(phrase)  <> with_consonants_suffix(phrase)
    end
  end

  def with_consonants_preffix(phrase) do
    String.slice(phrase, count_consonants(phrase)..-1)
  end

  def with_consonants_suffix(phrase) do
     suffix = get_consonants(phrase)
     List.to_string(suffix) <> "ay"
  end

  def get_consonants(phrase) do
    String.to_charlist(phrase) |> Enum.take_while(fn n -> n not in [?a, ?e, ?i, ?o, ?u] end)
  end

  def count_consonants(phrase) do
    get_consonants(phrase) |> Enum.count
  end
end
