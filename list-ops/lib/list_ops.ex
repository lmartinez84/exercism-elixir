defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    length(l, 0)
  end

  defp length([_head | tail], n), do: length(tail, n + 1)
  defp length([], n), do: n

  @spec reverse(list) :: list
  def reverse(l) do
    reverse_list(l, [])
  end

  defp reverse_list([head | tail], new), do: reverse_list(tail, [head | new])
  defp reverse_list([], new), do: new

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for x <- l, do: f.(x)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for x <- l, f.(x), do: x
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    reduce_fn(l, acc, f)
  end

  defp reduce_fn([head | tail], acc, f), do: reduce_fn(tail, f.(head, acc), f)
  defp reduce_fn([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append(a, b) do
    reverse(app(b, reverse(a)))
  end

  defp app([], new), do: new
  defp app([head | tail], new), do: app(tail, [head | new])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reverse(concat_fn(ll, []))
  end

  def concat_fn([], acc), do: acc
  def concat_fn([[] | tail], acc), do: concat_fn(tail, acc)
  def concat_fn([[l] | tail], acc), do: concat_fn(tail, [l | acc])

  def concat_fn([[head | tail_one] | tail_two], acc),
    do: concat_fn([tail_one | tail_two], [head | acc])
end
