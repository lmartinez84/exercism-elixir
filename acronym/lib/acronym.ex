defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  def abbreviate(string) do
    string
    # |> Macro.underscore()
    |> String.replace(["_", "-"], " ")
    |> String.split(~r{\s+|(?=[A-Z][a-z])})
    |> Enum.filter(&(String.length(&1) != 0))
    |> Enum.map(&String.first/1)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join()
  end

end
