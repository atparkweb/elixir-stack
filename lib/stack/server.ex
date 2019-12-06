defmodule Stack.Server do
  use GenServer
  
  ####
  # External API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end
  
  def pop do
    GenServer.call __MODULE__, :pop
  end
  
  def push(value) do
    GenServer.cast __MODULE__, { :push, value }
  end

  ####
  # GenServer implementation
  def init(_) do
    { :ok, Stack.Stash.get() }
  end
  
  def handle_call(:pop, _from, [head|tail]) do
    Stack.Stash.update(tail)
    { :reply, head, tail }
  end
  
  def handle_cast({ :push, value }, list) do
    Stack.Stash.update([value | list])
    { :noreply, [value|list]}
  end
  
  def terminate(reason, list) do
    Stack.Stash.update(list)
    IO.puts "Server process will terminate. Reason: #{inspect reason}, State: #{inspect list}"
  end
end
