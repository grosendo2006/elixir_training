defmodule FizzBuzz do

  @doc """
  Given 3 arguments . If the first two are zero, return “FizzBuzz”.
  If the first is zero, return “Fizz”. If the second is zero return “Buzz”.
  Otherwise return the third argument

  ## Examples

    iex> FizzBuzz.fuzzle(0,0,1)
    "FizzBuzz"

    iex> FizzBuzz.fuzzle(0,1,1)
    "Fizz"

    iex> FizzBuzz.fuzzle(1,0,1)
    "Buzz"

    iex> FizzBuzz.fuzzle(1,1,10)
    10

  """
  def fuzzle(0, 0, _), do: "FizzBuzz"
  def fuzzle(0, _, _), do: "Fizz"
  def fuzzle(_, 0, _), do: "Buzz"
  def fuzzle(_, _, x), do: x
end
