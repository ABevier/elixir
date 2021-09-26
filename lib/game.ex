defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Game.hello()
      :world

  """
  def hello do
    :world
  end

  def render do
    board = %{
      0 => %{ 4 => "X"},
      3 => %{ 2 => "Y"}
    }

    header_row = Enum.reduce(0..9, "   ", fn x, acc -> acc <> "#{x} " end)

    str = Enum.reduce(0..5, "", fn y, acc ->
      # Enum.each 0..9, fn x ->
      #   val = Map.get(board, y, %{})
      #   |> Map.get(x, ".")

      #   IO.puts("(#{x},#{y})->#{val}")
      # end

      row = Enum.reduce(0..9, "#{y}: ", fn x, acc ->
        val = Map.get(board, y, %{})
        |> Map.get(x, ".")
        acc <> "#{val} "
      end)
      acc <> row <> "\n"
    end)

    IO.puts(header_row <> "\n" <> str)

    # Enum.each board, fn {y, row} ->
    #   Enum.each row, fn {x, val} ->
    #     IO.puts("(#{x},#{y})->#{val}")
    #   end
    # end
  end
end
