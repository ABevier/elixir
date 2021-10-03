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

  def distance_between(%Position{x: x1, y: y1}, %Position{x: x2, y: y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def find_neighbors(%Position{x: x, y: y}, max_x, max_y) do
    []
    |> prepend_if(x - 1 >= 0, pos(x - 1, y))
    |> prepend_if(x + 1 < max_x, pos(x + 1, y))
    |> prepend_if(y - 1 >= 0, pos(x, y - 1))
    |> prepend_if(y + 1 < max_y, pos(x, y + 1))
  end

  def find_all_in_range(pos, range, max_x, max_y) do
    bfs([{pos, range}], max_x, max_y, MapSet.new())
  end

  # empty list is done
  defp bfs([], _max_x, _max_y, visited) do
    visited
  end

  # 0 range means visit this tile and move on
  defp bfs([{pos, 0} | rest], max_x, max_y, visited) do
    bfs(rest, max_x, max_y, MapSet.put(visited, pos))
  end

  # add all neighbors to the BACK of the list to ensure that higher range
  # paths are checked first
  defp bfs([{pos, range} | rest], max_x, max_y, visited) do
    neighbors = find_neighbors(pos, max_x, max_y)
    |> Enum.filter(fn n -> !MapSet.member?(visited, n) end)
    |> Enum.map(fn n -> {n, range - 1 } end)

    bfs(rest ++ neighbors, max_x, max_y, MapSet.put(visited, pos))
  end

  # this solution doesn't work, the visited tiles block valid paths
  # using dfs is just bad here

  # def find_all_in_range(pos, range, max_x, max_y) do
  #   dfs(pos, range, max_x, max_y, MapSet.new())
  # end

  # defp dfs(next, 0, _max_x, _max_y, visited) do
  #   MapSet.put(visited, next)
  # end

  # defp dfs(next, range, max_x, max_y, visited) do
  #   visited = MapSet.put(visited, next)
  #   find_neighbors(next, max_x, max_y)
  #   |> Enum.filter(fn n -> !MapSet.member?(visited, n) end)
  #   |> Enum.reduce(visited, fn (elem, acc) -> dfs(elem, range - 1, max_x, max_y, acc) end)
  # end

end
