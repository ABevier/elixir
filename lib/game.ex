defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  defstruct heroes: []

  def create do
    %Game{
      heroes: [
        %Hero{
          name: "A",
          position: %Position{x: 1, y: 1},
          hp: 800
        },
        %Hero{
          name: "B",
          position: %Position{x: 2, y: 2},
          hp: 800
        },
        %Hero{
          name: "C",
          position: %Position{x: 1, y: 3},
          hp: 800
        },
        %Hero{
          name: "X",
          position: %Position{x: 7, y: 1},
          hp: 800
        },
        %Hero{
          name: "Y",
          position: %Position{x: 6, y: 2},
          hp: 800
        },
        %Hero{
          name: "Z",
          position: %Position{x: 7, y: 3},
          hp: 800
        },
      ]
    }
  end

  def find_hero_at(%Game{heroes: heroes}, position) do
    Enum.find(heroes, nil, fn hero -> hero.position == position end)
  end
end
