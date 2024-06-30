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
    |> get_color()
  end

  defp calculate_hash(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identiek.Image{hex: hex}
  end

  defp get_color(struct) do
    hex = struct
    Enum.take(hex.hex, 3)
  end
end
