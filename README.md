# Game

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `game` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:game, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/game](https://hexdocs.pm/game).

### Notes

- Input should be two tiles / coordinates. Source and Dest. The game figures out the desired command from that.
- Essentially all inputs are based on a combination of range and what occupies destination tile:
  - empty square
  - enemy hero in square
  - friendly hero in square
  - self(?)
- The flow is Input -> Command -> Apply Command -> Get new state (or an error and reason)
