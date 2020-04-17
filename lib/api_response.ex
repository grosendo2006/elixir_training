defmodule ApiResponse do

  @doc """
  Given 3 arguments . receive an tuple, the first item will be an atom
  (:ok and :error) and the other one will be a map
  ## Examples
    iex> ApiResponse.handle_response_1_cond({:ok, %{:what => "what"}})
    "OK"
    iex> ApiResponse.handle_response_1_cond({:error, %{:what => "what"}})
    "Error"
    iex> ApiResponse.handle_response_1_cond({:whatever, %{:what => "what"}})
    :no_match_message_error
  """

  def handle_response_1_cond({a, _}) do
    cond do
      a == :ok    -> "OK"
      a == :error -> "Error"
      true        -> :no_match_message_error
    end
  end

  @doc """
  Given 3 arguments . receive an tuple, the first item will be an atom
  (:ok and :error) and the other one will be a map
  ## Examples
    iex> ApiResponse.handle_response_1_case({:ok, %{:what => "what"}})
    "OK"
    iex> ApiResponse.handle_response_1_case({:error, %{:what => "what"}})
    "Error"
    iex> ApiResponse.handle_response_1_case({:whatever, %{:what => "what"}})
    :no_match_message_error
  """

  def handle_response_1_case({a, _}) do
    case a do
      :ok    -> "OK"
      :error -> "Error"
      _      -> :no_match_message_error
    end
  end

   @doc """
  Given 3 arguments . receive an tuple, the first item will be an atom
  (:ok and :error) and the other one will be a map
  ## Examples
    iex> ApiResponse.handle_response_1_if_else({:ok, %{:what => "what"}})
    "OK"
    iex> ApiResponse.handle_response_1_if_else({:error, %{:what => "what"}})
    "Error"
    iex> ApiResponse.handle_response_1_if_else({:whatever, %{:what => "what"}})
    :no_match_message_error
  """

  def handle_response_1_if_else({a, _}) do
    if a == :ok do
      "OK"
    else if a == :error do
        "Error"
      else
        :no_match_message_error
      end
    end
  end

   @doc """
  Given 3 arguments . receive an tuple, the first item will be an atom
  (:ok and :error) and the other one will be a map
  ## Examples
    iex> ApiResponse.handle_response_1({:ok, %{:what => "what"}})
    "OK"
    iex> ApiResponse.handle_response_1({:error, %{:what => "what"}})
    "Error"
    iex> ApiResponse.handle_response_1({:whatever, %{:what => "what"}})
    :no_match_message_error
  """

  def handle_response_1({:ok, _}), do: "OK"
  def handle_response_1({:error, _}), do: "Error"
  def handle_response_1({_, _}), do: :no_match_message_error
end
