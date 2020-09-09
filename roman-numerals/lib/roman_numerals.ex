defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert(number)
  end

  def convert(number) when number >= 400 and number < 500, do: "CD" <> convert(number - 400)
  def convert(number) when number >= 500 and number < 900, do: "D" <> convert(number - 500)
  def convert(number) when number >= 900 and number < 1000, do: "CM" <> convert(number - 900)

  def convert(number) when number >= 1000 do
    n = div(number, 1000)
    converted =  1..n |> Enum.map(fn _ -> "M" end) |> Enum.join("")
    remainder = number - (n *1000)
    converted <>  convert(remainder)
  end

  def convert(0), do: ""
  def convert(number) when number < 4, do: 1..number |> Enum.map(fn _ -> "I" end) |> Enum.join("")
  def convert(number) when number == 4, do: "IV"
  def convert(number) when number < 9,  do: "V" <> convert(number - 5)
  def convert(number) when number == 9,  do: "IX"

  def convert(number) when number < 40 do
    n = div(number, 10)
    converted = 1..n |> Enum.map(fn _ -> "X" end) |> Enum.join("")
    remainder = number - (n * 10)
    converted <> convert(remainder)
  end

  def convert(number) when number < 50, do: "XL" <> convert(number - 40)
  def convert(number) when number <= 90, do: "L" <> convert(number - 50)
  def convert(number) when number < 100, do: "XC" <> convert(number - 90)
  def convert(number) when number >= 100, do: "C" <> convert(number - 100)
end
