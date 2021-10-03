defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  defstruct heroes: %{}

  # TODO: put this inside of a GenServer so I can store state!

  def create do
    # TODO: refactor this...
    %Game{
      heroes: %{
        1 => %Hero{
          name: "A",
          id: 1,
          position: %Position{x: 1, y: 1},
          hp: 800
        },
        2 => %Hero{
          name: "B",
          id: 2,
          position: %Position{x: 2, y: 2},
          hp: 800
        },
        3 => %Hero{
          name: "C",
          id: 3,
          position: %Position{x: 1, y: 3},
          hp: 800
        },
        4 => %Hero{
          name: "X",
          id: 4,
          position: %Position{x: 7, y: 1},
          hp: 800
        },
        5 => %Hero{
          name: "Y",
          id: 5,
          position: %Position{x: 6, y: 2},
          hp: 800
        },
        6 => %Hero{
          name: "Z",
          id: 6,
          position: %Position{x: 7, y: 3},
          hp: 800
        },
      }
    }
  end

  def find_hero_at(%Game{heroes: heroes}, position) do
    # TODO: consider building and caching a collision map on the game? instead of iterating
    found = Enum.find(heroes, nil, fn {_, hero} -> hero.position == position end)
    case found do
      {_, hero} -> {:ok, hero}
      nil -> {:error, "no hero at #{position}"}
    end
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

  def damage_hero(game, id, amount) do
    hero = game.heroes[id]
    update_hero = %{game.heroes[id] | hp: hero.hp - amount}
    new_state = put_in(game.heroes[id], update_hero)
    {:ok, new_state}
  end

end
