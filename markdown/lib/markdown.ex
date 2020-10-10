defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  # Several functions were refactored to take advantage of pipe operator
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> add_ul_tags_if_list()
  end

  # process was refactored to multiclause functions using pattern matching
  defp process("#" <> _ = word) do
    word
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  defp process("*" <> _ = word) do
    word
    |> parse_list_md_level()
  end

  defp process(word) do
    word
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  # I did not know how to refactor this function.
  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    l
    |> String.trim_leading("* ")
    |> String.split()
    |> enclose_with_list_items_tags()
  end

  defp enclose_with_list_items_tags(t), do: "<li>" <> join_words_with_tags(t) <> "</li>"

  # extracted two helpers functions to create header preffix and suffix based on header length.
  defp enclose_with_header_tag({header_length, enclosed}) do
    create_length_based_preffix_header(header_length) <>
      enclosed <> create_length_based_suffix_header(header_length)
  end

  defp create_length_based_preffix_header(header_length), do: "<h" <> header_length <> ">"
  defp create_length_based_suffix_header(header_length), do: "</h" <> header_length <> ">"

  defp enclose_with_paragraph_tag(t) do
    t
    |> join_words_with_tags()
    |> add_paragraph_tags()
  end

  defp add_paragraph_tags(t), do: "<p>#{t}</p>"

  defp join_words_with_tags(t) do
    t
    |> Enum.map_join(" ", &replace_md_with_tag/1)
  end

  defp replace_md_with_tag(w) do
    w
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    w
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_prefix("_", "<em>")
  end

  defp replace_suffix_md(w) do
    w
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_suffix("_", "</em>")
  end

  defp add_ul_tags_if_list(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
