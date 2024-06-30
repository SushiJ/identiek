defmodule Identiek do
  @moduledoc """
  Documentation for `Identiek`.
  """

  def hello do
    :world
  end

  def main(input) do
    input
    |> calculate_hash()

    # |> get_color()
  end

  defp calculate_hash(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end

  # defp get_color(list) do
  #   list
  #   |> Enum.take(3)
  # end
end
