defmodule FizzBuzz do
  @doc """
  Given 3 arguments . If the first two are zero, return “FizzBuzz”.
  If the first is zero, return “Fizz”. If the second is zero return “Buzz”.
  Otherwise return the third argument
  ## Examples
    iex> FizzBuzz.fuzzle_cond(0,0,1)
    "FizzBuzz"
    iex> FizzBuzz.fuzzle_cond(0,1,1)
    "Fizz"
    iex> FizzBuzz.fuzzle_cond(1,0,1)
    "Buzz"
    iex> FizzBuzz.fuzzle_cond(1,1,10)
    10
  """
  def fuzzle_cond(a,b,c) do
    cond do
      a == 0 && b == 0 -> "FizzBuzz"
      a == 0 -> "Fizz"
      b == 0 -> "Buzz"
      true -> c
    end
  end

  @doc """
  Given 3 arguments . If the first two are zero, return “FizzBuzz”.
  If the first is zero, return “Fizz”. If the second is zero return “Buzz”.
  Otherwise return the third argument
  ## Examples
    iex> FizzBuzz.fuzzle_case(0,0,1)
    "FizzBuzz"
    iex> FizzBuzz.fuzzle_case(0,1,1)
    "Fizz"
    iex> FizzBuzz.fuzzle_case(1,0,1)
    "Buzz"
    iex> FizzBuzz.fuzzle_case(1,1,10)
    10
  """

  def fuzzle_case(a,b,c) do
    case {a,b,c} do
      {0,0,_} -> "FizzBuzz"
      {0,_,_} -> "Fizz"
      {_,0,_} -> "Buzz"
      {_,_,c} -> c
    end
  end
end
