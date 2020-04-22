defmodule Truco.Player do
  defstruct cards: nil, name: nil, score_hand: 0, score: 0, card_selected: nil

  @doc """
  get card selected form the player cards
  """
  def player_choose(cards, card_number)do
    Enum.at(cards, card_number - 1)
  end

  @doc """
  In the first turn, get the second best card, in the second turn
  get the worse and let the best card for the last turn
  (most popular way to play)
  """
  def pc_choose(cards)do
    best_choice(cards)
  end

  defp best_choice(cards) do
    cards = Enum.sort(cards, &(&1.magic <= &2.magic))
    cond do
      Enum.count(cards) == 3 -> second_best(cards)
      Enum.count(cards) == 2 -> worst(cards)
      true -> best(cards)
    end
  end

  defp second_best(cards), do: Enum.at(cards, 1)

  defp worst(cards), do: Enum.at(cards, 0)

  defp best(cards), do: Enum.at(cards, 0)
end
