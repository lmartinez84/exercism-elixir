defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    add_num_bottles(number)
  end

  def add_num_bottles(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def add_num_bottles(number) do
    """
    #{number} #{bottles(number)} of beer on the wall, #{number} #{bottles(number)} of beer.
    Take #{take_subject(number)} down and pass it around, #{rest(number)} #{bottles(number - 1)} of beer on the wall.
    """
  end

  defp bottles(1), do: "bottle"
  defp bottles(_), do: "bottles"

  defp take_subject(1), do: "it"
  defp take_subject(_number), do: "one"

  defp rest(1), do: "no more"
  defp rest(2), do: 1
  defp rest(number), do: number - 1

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()

  def lyrics, do: lyrics(99..0)
  def lyrics(range) do
    range
    |> Enum.reduce("", fn n, acc -> acc <> verse(n) <> "\n" end)
    |> String.slice(0..-2)
  end
end
