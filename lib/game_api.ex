defmodule Game.Api do
  use GenServer

  def start_link(opts)  do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def input(server, source_pos, dest_pos) do
    case GenServer.call(server, {:input, source_pos, dest_pos}) do
      {:ok, game} -> Game.Board.render_game(game)
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  @impl true
  def init(:ok) do
    {:ok, Game.create}
  end

  @impl true
  def handle_call({:input, source, dest}, _from, state) do
    case Game.Input.handle_input(state, source, dest) do
      {:ok, game} -> {:reply, {:ok, game}, game}
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end


end
