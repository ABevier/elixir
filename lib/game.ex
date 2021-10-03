defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  defstruct heroes: %{}

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

  # TODO: consider building and caching a collision map instead of iterating
  def find_hero_at(%Game{heroes: heroes}, position) do
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

  #TODO: Consider moving input to Game.Input module?
  #TODO: figure out this typespec stuff
  @spec handle_input(%Game{}, %Position{}, %Position{}) :: {:ok, %Game{}} | {:error, String}
  def handle_input(game, source, dest) do
    case find_hero_at(game, source) do
      {:ok, hero} -> hero_handle_input(game, hero, dest)
      {:error, reason } -> {:error, reason}
    end
  end

  @spec handle_input(%Game{}, %Hero{}, %Position{}) :: %Game{} | {:error, String}
  def hero_handle_input(game, %Hero{} = hero, dest) do
    move_hero(game, hero.id, dest)
  end

end
