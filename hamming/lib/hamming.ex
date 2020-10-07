defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    compare_strands(0, strand1, strand2)
  end

  defp compare_strands(n, [h1 | t1], [h2 | t2]) do
    compute_if_different({h1, h2}, n)
    |> compare_strands(t1, t2)
  end

  defp compare_strands(n, [], []) do
    {:ok, n}
  end

  defp compare_strands(_, [], [_ | _]) do
    {:error, "Lists must be the same length"}
  end

  defp compare_strands(_, [_ | _], []) do
    {:error, "Lists must be the same length"}
  end

  defp compute_if_different({nucleotide1, nucleotide2}, n) when nucleotide1 != nucleotide2 do
    n + 1
  end

  defp compute_if_different(_, n), do: n
end
