defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    apply_fn(list, fun, [])
  end

  def apply_fn([head | tail], fun, result) do
    new_res = List.insert_at(result, -1, fun.(head))
    apply_fn(tail, fun, new_res)
  end

  def apply_fn([], _, result), do: result
end
