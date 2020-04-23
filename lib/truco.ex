defmodule Truco do
  alias Truco.Game
  alias Truco.Player
  alias Truco.Card

  @moduledoc """
  This is the Truco module.
  """
  @doc """
    Call this function to start the game
  """
  def play do
    IO.puts("Welcome to Truco")
    name = IO.gets("What is your name ? ")
    Game.create_deck()
    |> Game.shuffle()
    |> play_game([%Player{name: name}, %Player{name: "PC"}])
  end

  @doc """
  Return truco winner
  (The winner of 2 hands wins, to make it short and easy to play)
  Deal and call a new hand
  """

  def play_game(deck,[%Player{score: score_1, name: name_1},
                      %Player{score: score_2, name: name_2}] = list_players)do
    cond do
      score_1 == 2 -> IO.puts("Truco Winner: #{name_1}")
      score_2 == 2 -> IO.puts("Truco Winner: #{name_2}")
      true -> deck
                |> Game.deal(list_players)
                |> play_hand()
    end
  end

  @doc """
  Return hand winner
  """
  def play_hand([%Player{cards: [], score_hand: score_hand_1, score: score_1, name: name_1} = player_1,
                 %Player{cards: [], score_hand: score_hand_2, score: score_2, name: name_2} = player_2]) do
    players = cond do
      score_hand_1 > score_hand_2 ->
        IO.puts("Hand winner: #{name_1}")
        [
          %Player{player_1 | score: score_1 + 1, score_hand: 0},
          %Player{player_2 | score_hand: 0}
        ]
      score_hand_1 < score_hand_2 ->
        IO.puts("Hand winner: #{name_2}")
        [
          %Player{player_1 | score_hand: 0},
          %Player{player_2 | score: score_2 + 1,score_hand: 0}
        ]
      true ->
        IO.puts("Tie !")
        [
          %Player{player_1 | score: score_1 + 1, score_hand: 0},
          %Player{player_2 | score: score_2 + 1, score_hand: 0}
        ]
    end
    Game.create_deck()
          |> Game.shuffle()
          |> play_game(players)
  end

  @doc """
  Start a new hand
  """
  def play_hand(list_players) do
    list_players
    |> choose
    |> compare
    |> win_or_loose
    |> check
  end

  @doc """
  player and pc select cards
  """
  def choose([%Player{cards: cards_1} = player_1, %Player{cards: cards_2}= player_2]) do
    IO.puts("Here are yours cards")
    IO.inspect cards_1
    cards_1
    |> Enum.map(fn %Card{name: name} -> IO.puts(name) end)

    options = Enum.to_list(1..Enum.count(cards_1))
    card_number_player_1 = get_number_in("Choose your card \n#{ inspect options}\n", options)

    card_player_1 =
      cards_1
      |> Player.player_choose(card_number_player_1)

    card_player_2 =
      cards_2
      |> Player.pc_choose()
    IO.puts("PC's choice #{card_player_2.name}")
    [
      %Player{player_1 | card_selected: card_player_1, cards: cards_1},
      %Player{player_2 | card_selected: card_player_2, cards: cards_2}
    ]
  end

  @doc """
  compare player and pc cards
  ## Examples
    iex> players = [%Truco.Player{card_selected: %Truco.Card{name: "1 de Espada", magic: 13} }, %Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}]
    iex> Truco.compare(players)
    {:win, [%Truco.Player{card_selected: %Truco.Card{name: "1 de Espada", magic: 13} }, %Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}]}

    iex> players = [%Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}, %Truco.Player{card_selected: %Truco.Card{name: "1 de Espada", magic: 13} }]
    iex> Truco.compare(players)
    {:loose, [%Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}, %Truco.Player{card_selected: %Truco.Card{name: "1 de Espada", magic: 13} }]}

    iex> players = [%Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}, %Truco.Player{card_selected: %Truco.Card{name: "2 de Copa", magic: 8} }]
    iex> Truco.compare(players)
    {:tie, [%Truco.Player{card_selected:  %Truco.Card{name: "2 de Espada", magic: 8}}, %Truco.Player{card_selected: %Truco.Card{name: "2 de Copa", magic: 8} }]}

  """
  def compare([
        %Player{card_selected: %Card{magic: magic_1}} = player_1,
        %Player{card_selected: %Card{magic: magic_2}} = player_2
      ]) do
    cond do
      magic_1 > magic_2 ->
        {:win, [player_1, player_2]}

      magic_1 < magic_2 ->
        {:loose, [player_1, player_2]}

      true ->
        {:tie, [player_1, player_2]}
    end
  end

  @doc """
  return the winner for the point
  """
  def win_or_loose(
        {status, [%Player{score_hand: score_hand_1, name: name_1} = player_1,
                  %Player{score_hand: score_hand_2, name: name_2} = player_2]}
      ) do
    case status do
      :win ->
        IO.puts("Hand point for #{name_1}")
        [%Player{player_1 | score_hand: score_hand_1 + 1}, player_2]

      :loose ->
        IO.puts("Hand point for #{name_2}")
        [player_1, %Player{player_2 | score_hand: score_hand_2 + 1}]

      :tie ->
        IO.puts(" Tie !")
        [player_1, player_2]
    end
  end

  @doc """
  Quit card selected from player and pc for the hand
  """
  def check([
        %Player{cards: cards_1, card_selected: %Card{name: card_name_1}} = player_1,
        %Player{cards: cards_2, card_selected: %Card{name: card_name_2}} = player_2
      ]) do
    cards_remained_1 =
      cards_1
      |> Enum.filter(fn %Card{name: card_name_filter_1} -> card_name_filter_1 != card_name_1 end)

    cards_remained_2 =
      cards_2
      |> Enum.filter(fn %Card{name: card_name_filter_2} -> card_name_filter_2 != card_name_2 end)

    [
      %Player{player_1 | cards: cards_remained_1, card_selected: nil},
      %Player{player_2 | cards: cards_remained_2, card_selected: nil}
    ]
    |> play_hand
  end

  defp get_number_in(promt, list) do
    string =
      IO.gets(promt)
      |> String.trim()

    case string do
      "" ->
        get_number_in(promt, list)

      number ->
        check(number, promt,list)
    end
  end

  defp check(number, promt, list)do
    if Enum.member?(list, String.to_integer(number)) do
      String.to_integer(number)
    else
      get_number_in(promt, list)
    end
  end

end
