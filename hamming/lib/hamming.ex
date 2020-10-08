defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    compare_strands(strand1, strand2, 0)
  end

  @spec compare_strands([char], [char], non_neg_integer) :: {:ok, non_neg_integer} | {:error, String.t()}
  defp compare_strands([nucleotide | t1], [nucleotide | t2], n) do
    compare_strands(t1, t2, n)
  end

  defp compare_strands([_ | t1], [_ | t2], n) do
    compare_strands(t1, t2, n + 1)
  end

  defp compare_strands([], [], n) do
    {:ok, n}
  end

  defp compare_strands([], [_ | _], _) do
    {:error, "Lists must be the same length"}
  end

  defp compare_strands([_ | _], [],_) do
    {:error, "Lists must be the same length"}
  end

end
