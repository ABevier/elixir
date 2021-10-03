defmodule Game.Utils do

  def prepend_if(list, false, _item) do
    list
  end

  def prepend_if(list, true, item) do
    [item | list]
  end
end
