defmodule CrossCommerceTestWeb.MergeSort do
  def sort([]), do: []
  def sort([_] = list), do: list

  def sort(list) when is_list(list) do
    {left, right} = Enum.split(list, div(length(list), 2))
    sort(sort(left), sort(right), [])
  end

  defp sort(left, [], acc), do: Enum.reverse(acc) ++ left
  defp sort([], right, acc), do: Enum.reverse(acc) ++ right

  defp sort([left_head | left_tail] = _, [right_head | _right_tail] = right, acc)
       when left_head <= right_head do
    sort(left_tail, right, [left_head | acc])
  end

  defp sort([left_head | _left_tail] = left, [right_head | right_tail] = _right, acc)
       when left_head > right_head do
    sort(left, right_tail, [right_head | acc])
  end
end
