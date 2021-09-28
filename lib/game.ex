defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  defstruct heroes: %{}

  def create do
    %Game{
      heroes: %{
        1 => %Hero{
          name: "A",
          position: %Position{x: 1, y: 1},
          hp: 800
        },
        2 => %Hero{
          name: "B",
          position: %Position{x: 2, y: 2},
          hp: 800
        },
        3 => %Hero{
          name: "C",
          position: %Position{x: 1, y: 3},
          hp: 800
        },
        4 => %Hero{
          name: "X",
          position: %Position{x: 7, y: 1},
          hp: 800
        },
        5 => %Hero{
          name: "Y",
          position: %Position{x: 6, y: 2},
          hp: 800
        },
        6 => %Hero{
          name: "Z",
          position: %Position{x: 7, y: 3},
          hp: 800
        },
      }
    }
  end

  # TODO: consider building and caching a collision map instead of iterating
  def find_hero_at(%Game{heroes: heroes}, position) do
    Enum.find(heroes, nil, fn {_, hero} -> hero.position == position end)
  end

  def is_hero_at?(%Game{heroes: heroes}, position) do
    Enum.any?(heroes, fn {_, hero} -> hero.position == position end)
  end

  def move_hero(game, id, new_pos) do
    if is_hero_at?(game, new_pos) do
      {:error, "position #{new_pos} is already occupied"}
    else
      updated_hero = %{game.heroes[id] | position: new_pos}
      new_state = put_in(game.heroes[id], updated_hero)
      {:ok, new_state}
    end
  end
end
