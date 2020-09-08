defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text) |> Enum.map(&cipher(&1, shift)) |> List.to_string()
  end

  @spec cipher(char :: integer, encode :: integer) :: integer()
  defp cipher(char, encode) when char in ?A..?Z, do: encrypt(char, encode, ?A)
  defp cipher(char, encode) when char in ?a..?z, do: encrypt(char, encode, ?a)
  defp cipher(char, _encode), do: char

  @spec encrypt(char :: integer, encode :: integer, cases :: integer) :: integer()
  defp encrypt(char, encode, cases), do: rem(char - cases + encode, 26) + cases
end
