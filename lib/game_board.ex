defmodule Game.Board do

  # TODO: figure out how these specs work
  # @spec board_from_game(Game) :: Map
  def board_from_game(%Game{} = game) do
    Enum.reduce(game.heroes, %{}, fn {_, %Hero{name: name, position: pos}}, acc ->
      row = Map.get(acc, pos.y, %{})
      row = Map.put(row, pos.x, name)
      Map.put(acc, pos.y, row)
    end)
  end

  @doc """
  """
  # TODO: look up string vs non empty binary
  @spec render_board_to_string(Map):: nonempty_binary()
  def render_board_to_string(board) do
    header_row = Enum.reduce(0..8, "   ", fn x, acc -> acc <> "#{x} " end)

    str = Enum.reduce(0..4, "", fn y, y_acc ->
      row = Enum.reduce(0..8, "#{y}: ", fn x, x_acc ->
        val = Map.get(board, y, %{})
        |> Map.get(x, ".")
        x_acc <> "#{val} "
      end)
      y_acc <> row <> "\n"
    end)

    header_row <> "\n" <> str
  end

  def render_game(%Game{} = game) do
    game
    |> board_from_game
    |> render_board_to_string
    |> IO.puts
  end

end
