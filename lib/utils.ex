defmodule Game.Utils do

  def prepend_if(list, condition, item) do
    if condition do
      [item | list]
    else
      list
    end
  end

end
