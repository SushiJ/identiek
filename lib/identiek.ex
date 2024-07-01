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
    |> build_grid()
    |> fliter_out_odd()
    |> build_pixel_map()
  end

  defp calculate_hash(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identiek.Image{hex: hex}
  end

  defp get_color(%Identiek.Image{hex: h} = image) do
    color = Enum.take(h, 3)
    %Identiek.Image{image | color: color}
  end

  defp build_grid(%Identiek.Image{hex: hex_list} = image) do
    # INFO: &mirror_row(&1) / &mirror_row/1 same as fn l ->  mirror_row(l) end
    grid =
      hex_list
      |> Enum.chunk_every(3)
      |> Enum.take(5)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identiek.Image{image | grid: grid}
  end

  defp mirror_row(list) do
    [first, second | _tail] = list
    list ++ [second, first]
  end

  defp fliter_out_odd(%Identiek.Image{grid: grid} = image) do
    g =
      grid
      |> Enum.filter(fn {val, _} -> Integer.mod(val, 2) == 0 end)

    %Identiek.Image{image | grid: g}
  end

  defp build_pixel_map(%Identiek.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_val, idx} ->
        horizontal = rem(idx, 5) * 50
        vertical = div(idx, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identiek.Image{image | pixel_map: pixel_map}
  end
end
