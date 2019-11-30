defmodule Stack.Server do
  use GenServer
  
  def init(init_arg) do
    { :ok, init_arg }
  end

  def handle_call(:pop, _from, [head|tail]) do
    { :reply, head, tail }
  end
  
  def handle_cast({ :push, value }, list) do
    { :noreply, [value|list]}
  end
end
