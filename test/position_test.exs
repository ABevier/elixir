defmodule PositionTest do
  import Position
  use ExUnit.Case
  doctest Game

  test "should find range 2 in the middle" do
    expected = MapSet.new([
      pos(4, 2),
      pos(3, 2), pos(2, 2),
      pos(5, 2), pos(6, 2),
      pos(4, 1), pos(4, 0),
      pos(4, 3), pos(4, 4),
      pos(3, 1), pos(5, 3), pos(5, 1), pos(3, 3)
    ])

    assert find_all_in_range(pos(4, 2), 2, 9, 5) == expected
  end

  test "should find distance" do
    assert distance_between(pos(3, 3), pos(4,2)) == 2
  end

end
