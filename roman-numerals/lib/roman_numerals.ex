defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert(number)
  end

  def convert(number) when number >= 1000, do: "M" <> convert(number - 1000)
  def convert(number) when number >= 900 and number < 1000, do: "CM" <> convert(number - 900)
  def convert(number) when number >= 500 and number < 900, do: "D" <> convert(number - 500)
  def convert(number) when number >= 400 and number < 500, do: "CD" <> convert(number - 400)
  def convert(number) when number >= 100 and number < 400, do: "C" <> convert(number - 100)
  def convert(number) when number >= 90 and number < 100, do: "XC" <> convert(number - 90)
  def convert(number) when number >= 50 and number < 90, do: "L" <> convert(number - 50)
  def convert(number) when number >= 40 and number < 50, do: "XL" <> convert(number - 40)
  def convert(number) when number >= 10 and number < 40, do: "X" <> convert(number - 10)
  def convert(number) when number == 9, do: "IX"
  def convert(number) when number >= 5 and number < 9, do: "V" <> convert(number - 5)
  def convert(number) when number == 4, do: "IV"
  def convert(number) when number > 0 and number < 4, do: "I" <> convert(number - 1)
  def convert(number) when number == 0, do: ""



end
