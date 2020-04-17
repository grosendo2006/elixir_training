defmodule WordCount do


  @doc """
  Given a phrase, count the occurrences of each word in that phrase,

  ## Examples

    iex> WordCount.count("Hello all all one one one")
    %{"Hello" => 1, "all" => 2, "one" => 3}

  """
  def count(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.reduce(%{}, &increment/2)
  end

  defp increment(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
