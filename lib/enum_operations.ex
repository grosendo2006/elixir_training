defmodule EnumOperations do
  @doc """
  Given a list, returns the sum of all elements.

  ## Examples

    iex> EnumOperations.count([1,2,3,4])
    10

  Unknown params return an error:

    iex> EnumOperations.count(1)
    ** (FunctionClauseError) no function clause matching in EnumOperations.count/1

  """
  def count(list) when is_list(list) do
    do_count(list, 0)
  end

  defp do_count([], total), do: total

  defp do_count([head | tail], total) do
    do_count(tail, head + total)
  end

  @doc """
  Given a list, returns the reverse list.

  ## Examples

    iex> EnumOperations.reverse([1,2,3,4])
    [4,3,2,1]

  Unknown params return an error:

    iex> EnumOperations.reverse(1)
    ** (FunctionClauseError) no function clause matching in EnumOperations.reverse/1

  """

  def reverse(list) when is_list(list) do
    do_reverse(list, [])
  end

  defp do_reverse([], reverse_list), do: reverse_list

  defp do_reverse([head | tail], reverse_list) do
    do_reverse(tail, [ head | reverse_list ])
  end

  @doc """
  Given a list and a function, returns only those elements for which
  function returns a truthy value .

  ## Examples

    iex> EnumOperations.filter([1,2,4,8,9], fn(x) -> rem(x, 2) == 0 end)
    [2,4,8]

  Unknown params return an error:

    iex> EnumOperations.filter(1,1)
    ** (FunctionClauseError) no function clause matching in EnumOperations.filter/2

  """
  def filter(list, function) when is_list(list) and is_function(function) do
    for elem <- list, function.(elem) do
      elem
    end
  end
end
