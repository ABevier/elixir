defmodule Game.Input do
  import Game

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
    command_fns = [&match_move/3, &match_attack/3]

    command_to_execute = Enum.find_value(command_fns, nil, fn f -> f.(game, hero, dest) end)

    case command_to_execute do
      {cmd_name, cmd} -> IO.puts(cmd_name)
        cmd.()
      nil -> {:error, "no valid command can be executed on #{dest}"}
    end
  end

  def match_move(game, hero, dest) do
    if can_move(game, hero, dest) do
      {:move_cmd, fn () -> move_hero(game, hero.id, dest) end}
    else
      nil
    end
  end

  def can_move(game, hero, dest) do
    distance = Position.distance_between(hero.position, dest)
    distance <= 2 && !Game.is_hero_at?(game, dest)
  end

  def match_attack(game, hero, dest) do
    if can_attack(game, hero, dest) do
      {:ok, target} = Game.find_hero_at(game, dest)
      {:attack_cmd, fn () -> { damage_hero(game, target.id, 200)} end }
    else
      nil
    end
  end

  #TODO: make an "in-range" function
  def can_attack(game, hero, dest) do
    distance = Position.distance_between(hero.position, dest)
    distance == 1 && Game.is_hero_at?(game, dest)
  end

end
