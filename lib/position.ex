defmodule Position do
  import Game.Utils

  defstruct x: -1, y: -1

  defimpl String.Chars, for: Position do
    def to_string(%Position{x: x, y: y}) do
      "(#{x},#{y})"
    end
  end

  def pos(x, y) do
    %Position{x: x, y: y}
  end

  def find_neighbors(%Position{x: x, y: y}, max_x, max_y) do
    []
    |> prepend_if(x - 1 >= 0, pos(x - 1, y))
    |> prepend_if(x + 1 < max_x, pos(x + 1, y))
    |> prepend_if(y - 1 >= 0, pos(x, y - 1))
    |> prepend_if(y + 1 < max_y, pos(x, y + 1))
  end

  def find_all_in_range(pos, range, max_x, max_y) do
    bfs(pos, range, max_x, max_y, MapSet.new())
  end

  defp bfs(next, 0, _max_x, _max_y, visited) do
    MapSet.put(visited, next)
  end

  defp bfs(next, range, max_x, max_y, visited) do
    visited = MapSet.put(visited, next)
    find_neighbors(next, max_x, max_y)
    #|> Enum.filter(fn n -> !MapSet.member?(visited, n) end)
    |> Enum.reduce(visited, fn (elem, acc) -> bfs(elem, range - 1, max_x, max_y, acc) end)
  end

end
