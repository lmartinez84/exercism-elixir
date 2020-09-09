defmodule TwelveDays do
  @days %{
    1 => "first",
    2 => "second",
    3 => "third",
    4 => "fourth",
    5 => "fifth",
    6 => "sixth",
    7 => "seventh",
    8 => "eighth",
    9 => "ninth",
    10 => "tenth",
    11 => "eleventh",
    12 => "twelfth"
  }
  @text %{
    1 => "a Partridge in a Pear Tree.",
    2 => "two Turtle Doves",
    3 => "three French Hens",
    4 => "four Calling Birds",
    5 => "five Gold Rings",
    6 => "six Geese-a-Laying",
    7 => "seven Swans-a-Swimming",
    8 => "eight Maids-a-Milking",
    9 => "nine Ladies Dancing",
    10 => "ten Lords-a-Leaping",
    11 => "eleven Pipers Piping",
    12 => "twelve Drummers Drumming"
  }
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{@days[number]} day of Christmas my true love gave to me: #{
      elements_of_verse(number)
    }"
  end

  @spec elements_of_verse(number :: integer) :: String.t()
  defp elements_of_verse(number),
    do: Enum.reduce(number..1, "", fn element, acc -> acc <> add(acc, element) end)

  @spec add(text :: String.t(), number :: integer) :: String.t()
  defp add("", 1), do: @text[1]
  defp add(_text, 1), do: "and " <> add("", 1)
  defp add(_text, number) when number > 1, do: @text[number] <> ", "

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.reduce(
      starting_verse..ending_verse,
      "",
      fn element, acc -> acc <> verse(element) <> "\n" end
    )
    |> String.slice(0..-2)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
