defmodule Position do
  defstruct x: -1, y: -1

  defimpl String.Chars, for: Position do
    def to_string(%Position{x: x, y: y}) do
      "(#{x},#{y})"
    end
  end
end
