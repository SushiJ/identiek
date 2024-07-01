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
    |> chunk_list(3, 5)
    |> build_grid()
  end

  defp calculate_hash(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identiek.Image{hex: hex}
  end

  defp get_color(%Identiek.Image{color: _, hex: h}) do
    color = Enum.take(h, 3)
    %Identiek.Image{hex: h, color: color}
  end

  defp chunk_list(%Identiek.Image{color: _, hex: h}, chunk, take) do
    h
    |> Enum.chunk_every(chunk)
    |> Enum.take(take)
  end

  defp build_grid(list) do
    # INFO: &mirror_row(&1) same as fn l ->  mirror_row(l) end
    Enum.map(list, &mirror_row(&1))
  end

  defp mirror_row(list) do
    [first, second | _tail] = list
    list ++ [second, first]
  end
end
