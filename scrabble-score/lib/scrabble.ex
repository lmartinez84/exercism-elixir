defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.to_charlist()
    |> Enum.reduce(0, fn char, total -> total + compute(char) end)
  end

  def compute(char) when char in [?A, ?E, ?I, ?O, ?U, ?L, ?N, ?R, ?S, ?T], do: 1
  def compute(char) when char in [?D, ?G], do: 2
  def compute(char) when char in [?B, ?C, ?M, ?P], do: 3
  def compute(char) when char in [?F, ?H, ?V, ?W, ?Y], do: 4
  def compute(?K), do: 5
  def compute(char) when char in [?J, ?X], do: 8
  def compute(char) when char in [?Q, ?Z], do: 10
  def compute(_), do: 0
end
