defmodule Game.Utils do

  def prepend_if(list, false, _item), do: list
  def prepend_if(list, true, item), do: [item | list]
end
