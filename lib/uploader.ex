defmodule Uploader do

  @moduledoc """
    This module provides functionality to upload files to S3
  """

  @doc """
    Main function
  """
  def main(file_path) do
    get_file(file_path)
      |> upload_file(file_path)
  end

  @doc """
    Get a file to update
  """
  def get_file(file_path) do
    case File.read file_path do
      { :ok, binary } -> binary
      { :error, _reason } -> "That file does not exist"
    end
  end

  @doc """
   Upload a file to S3.
  """
  def upload_file(file_binary, file_path) do
    ExAws.S3.put_object("elixir-trainings", "grosendo/#{file_path}", file_binary)
    |> ExAws.request!()
  end
end
